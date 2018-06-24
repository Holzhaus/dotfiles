# -*- coding: utf-8 -*-
import subprocess
import os
import yaml


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
            yield from dict_attrs(v, '{}.{}'.format(path, k) if path else k)
    else:
        yield path, obj


xresources = read_xresources('*')
with open(os.path.join(config.configdir, 'config.yml'), mode='r') as f:
    yaml_data = yaml.load(f)
    for k, v in dict_attrs(yaml_data):
        if isinstance(v, str):
            v = v.format_map(xresources)
        config.set(k, v)
