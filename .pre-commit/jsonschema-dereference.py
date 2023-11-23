import json
from typing import List, Dict, Any
from pathlib import Path

import jsonref
import yaml
try:
    from yaml import CLoader as Loader, CDumper as Dumper
except ImportError:
    from yaml import Loader, Dumper
from jinja2 import Template

JSONSCHEMA_TEMPLATE_NAME = "values.schema.tmpl.json"
JSONSCHEMA_NAME = "values.schema.json"
VALUES_FILE = "values.yaml"
CHART_LOCK = "Chart.lock"

def read_yaml(file_path: Path):
    """Open and load Chart.yaml file."""
    with open(file_path, "r") as f:
        return yaml.load(f, Loader=Loader)

def template_schema(chart_dir: Path, lock: Dict[str, Any]):
    """Load values.schema.tmpl.json and template it via Jinja2."""
    with open(chart_dir / JSONSCHEMA_TEMPLATE_NAME, "r") as f:
        schema_template = Template(f.read())

    return json.loads(schema_template.render(lock))

def tidy_schema(schema: Any, values: Any):
    """Hack to support OCP Form view.

    https://issues.redhat.com/browse/OCPBUGS-14874
    https://issues.redhat.com/browse/OCPBUGS-14875
    """
    if isinstance(schema, dict):
        try:
            del schema["$schema"]
        except:
            pass
        try:
            del schema["format"]
        except:
            pass

        # Override existing defaults so OCP form view
        # doesn't try to override our defaults
        if schema.get("default") is not None and values is not None:
            schema["default"] = values

        # Tidy up properties for type: object
        properties: Dict[str, Any] = schema.get("properties", {})
        for k, v in properties.items():
            if isinstance(values, dict):
                new_values = values.get(k, None)
            else:
                new_values = None
            tidy_schema(v, new_values)

        # Tidy up properties for type: array
        items: Dict[str, Any] = schema.get("items", {})
        if items:
            tidy_schema(items, values)
    return schema

def save(chart_dir: Path, schema: Any):
    """Take schema containing $refs and dereference them."""
    with open(chart_dir / JSONSCHEMA_NAME, "w") as f:
        json.dump(schema, f, indent=4, sort_keys=True)

if __name__ == '__main__':
    charts = [p.parent for p in Path(".").rglob(CHART_LOCK)]

    errors: List[BaseException] = []
    for chart in charts:
        try:
            lock = read_yaml(chart / CHART_LOCK)
            values = read_yaml(chart / VALUES_FILE)
            schema_template = template_schema(chart, lock)
            schema = jsonref.replace_refs(schema_template)
            schema = tidy_schema(schema, values)

            save(chart, schema)
        except BaseException as e:
            print(f"Could not process schema for '{chart}': {e}")
            errors.append(e)
    if errors:
        exit(1)
