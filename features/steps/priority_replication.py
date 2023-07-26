import json

from behave import step


@step('I configure and start {name:w} with tags {data}')
def start_patroni_with_tags(context, name, data):
    data = data and json.loads(data)
    return context.pctl.start(name, custom_config={'tags': data})
