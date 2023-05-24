# Harmful Compared to What? The Problem of Gaming and Ill-defined Causal Effects

This repository contains the code required to reproduce all figures and simulations reported in our manuscript, *Harmful Compared to What? The Problem of Gaming and Ill-defined Causal Effects* (Magnusson, Johansson, & Przybylski, in preparation). 

## Materials
- Preprint
    - A publicly available version of our manuscript in advance of peer-review and formal publication
- [OSF repository](https://osf.io/qfw23/)
- Online analysis supplement ([PDF](https://github.com/rpsychologist/gaming-causal-inference-paper/blob/main/docs/magnusson-2023-gaming-harmful-compared-to-what-supplement.pdf), [HTML](https://rpsychologist.github.io/gaming-causal-consistency-paper))
    - The rendered version of `supplement.qmd`

## Reproducibility
You can render the supplement using either your local R installation or by using Docker.

The Quarto files will be output to `docs/` and figures to `figures/`.

### Build using a local R installation
The following dependencies are needed:
- R (v4.3.0)
- Quarto (v1.3.353)
    - With a working LaTeX installation
- Renv (v0.17.3)

The simply run:
```bash
R -e 'renv::restore()'
quarto render
```

### Build using Docker
You can also build the project using Docker, without having the install any additional dependencies.

```bash
docker build \
    --build-arg R_VERSION=4.3.0 \
    --build-arg QUARTO_VERSION=1.3.353 \
    --build-arg RENV_VERSION=0.17.3 \
    -t gaming-consistency .
```

Then use the Docker image to render the Quarto project.

```bash
docker run \
    --rm \
    -v "$(pwd)/supplement.qmd:/home/supplement.qmd" \
    -v "$(pwd)/figures:/home/figures" \
    -v "$(pwd)/_quarto.yml:/home/_quarto.yml" \
    gaming-consistency \
    quarto render
```
