# dotfiles
My . files

## Installation

To install/update, make sure to install `pipenv` to install `ansible` and then run the `main.yml`
playbook:

```
pip install pipenv
pipenv install
pipenv run ansible-playbook -i ansible/hosts ansible/main.yml
```

This playbook configures my dotfiles and installs the essential tools for my DevOps setup.
See `ansible/main.yml` for the details.

## Acknowledgements

* [mrolli](https://github.com/mrolli) for the idea to also use Ansible for the dotfiles

