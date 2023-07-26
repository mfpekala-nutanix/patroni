import json
import time

from behave import step, then

@step('I configure and start {name:w} with tags {data}')
def start_patroni_with_tags(context, name, data):
    data = data and json.loads(data)
    return context.pctl.start(name, custom_config={'tags': data})
