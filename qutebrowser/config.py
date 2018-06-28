# -*- coding: utf-8 -*-
import subprocess
import os
import yaml

# Silence linter errors
# pylint: disable=C0111
c = c  # noqa: F821 pylint: disable=E0602,C0103
config = config  # noqa: F821 pylint: disable=E0602,C0103

CONFIG_KEYS_DICT = (
    'aliases',
    'bindings.commands',
    'bindings.default',
    'bindings.key_mappings',
    'content.headers.custom',
    'content.javascript.log',
    'url.searchengines',
)


def read_xresources(prefix):
    props = {}
    x = subprocess.run(['xrdb', '-query'], stdout=subprocess.PIPE)
    lines = x.stdout.decode().split('\n')
    for line in filter(lambda l: l.partition('.')[0] == prefix, lines):
        prop, _, value = line.partition(':\t')
        props[prop.partition('.')[2]] = value
    return props


def dict_attrs(obj, path=''):
    if isinstance(obj, dict):
        for k, v in obj.items():
            newpath = '{}.{}'.format(path, k) if path else k
            if newpath in CONFIG_KEYS_DICT:
                print('set %s to %r' % (newpath, v))
                yield newpath, v
            else:
                yield from dict_attrs(v, newpath)
    else:
        yield path, obj


def read_yml(filename, xresources=None):
    with open(os.path.join(config.configdir, filename), mode='r') as f:
        yaml_data = yaml.load(f)
        for k, v in dict_attrs(yaml_data):
            if xresources and isinstance(v, str):
                v = v.format_map(xresources)
            config.set(k, v)


xresources = read_xresources('*')

config_files = (
    'appearance.yml',
    'config.yml',
)
for filename in config_files:
    read_yml(filename, xresources=xresources)
