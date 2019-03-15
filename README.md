[![Documentation Status](https://readthedocs.org/projects/polkadot-wiki/badge/?version=latest)](https://polkadot-wiki.readthedocs.io/en/latest/?badge=latest)

# Polkadot Wiki

[Polkadot wiki](https://wiki.polkadot.network)

This repo contains markdown files for the Polkadot wiki.

## Build

The wiki is hosted on [readthedocs](readthedocs.io) and is built automatically
from this repository whenever a new commit is pushed to master.

## Styling

The `cinder` directory contains all styling / theme components.

## Adding pages

When adding pages you must manually add the entry into the `nav`
field in the `mkdocs.yml` located in this directory. We do this
in order to have more control in the organization of the layout
of the wiki and otherwise auto-generate is too messy.
