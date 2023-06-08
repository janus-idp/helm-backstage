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
CHART_LOCK = "Chart.lock"

def parse_chart_lock(chart_dir: Path):
    """Open and load Chart.yaml file."""
    with open(chart_dir / CHART_LOCK, "r") as f:
        return yaml.load(f, Loader=Loader)

def template_schema(chart_dir: Path, lock: Dict[str, Any]):
    """Load values.schema.tmpl.json and template it via Jinja2."""
    with open(chart_dir / JSONSCHEMA_TEMPLATE_NAME, "r") as f:
        schema_template = Template(f.read())

    return json.loads(schema_template.render(lock))

def dereference_and_save(chart_dir: Path, schema_template: Any):
    """Take schema containing $refs and dereference them."""
    schema = jsonref.replace_refs(schema_template)
    with open(chart_dir / JSONSCHEMA_NAME, "w") as f:
        json.dump(schema, f, indent=4, sort_keys=True)

if __name__ == '__main__':
    charts = [p.parent for p in Path(".").rglob(CHART_LOCK)]

    errors: List[BaseException] = []
    for chart in charts:
        try:
            lock = parse_chart_lock(chart)
            schema_template = template_schema(chart, lock)

            dereference_and_save(chart, schema_template)
        except BaseException as e:
            print(f"Could not process schema for '{chart}': {e}")
            errors.append(e)
    if errors:
        exit(1)
