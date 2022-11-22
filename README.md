# Running [The Littlest JupyterHub](https://tljh.jupyter.org/en/latest/) on AWS for MHC
Resources for working with AWS for JupyterHub at MHC.



## Ignored files

Any file named `.DS_Store` or `secrets.txt` in any directory will be ignored by git.



## Structure

This repository holds a variety of things relating to standing up and managing an instance of [The Littlest JupyterHub](https://tljh.jupyter.org/en/latest/) on AWS.


### `.github/`

Contains configuration for GitHub. Specifically, this is where the pull request template is set.


### `documentation`

Documentation stuff. This may move out of the repository into some other format -- possibly the GitHub wiki?


### `jupyterhub_startup`

Scripts and tools to set up [The Littlest JupyterHub](https://tljh.jupyter.org/en/latest/) on an AWS server.


### `nbgrader_jupyterhub_startup`

Scripts and tools to configure [nbgrader](https://nbgrader.readthedocs.io/en/stable/) on an already configured instance of [The Littlest JupyterHub](https://tljh.jupyter.org/en/latest/).
