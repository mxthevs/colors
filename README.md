<br />

<p align="center">
  <img alt="colors" title="colors" src="https://raw.githubusercontent.com/mxthevs/colors/main/.github/colors.svg">
</p>

<p align="center">
  Extract colors from any text file!
</p>

<hr /> <br />

![OCaml](https://img.shields.io/badge/-OCaml-c15540?style=square&logo=ocaml&logoColor=white)
![build workflow](https://github.com/mxthevs/colors/actions/workflows/build.yml/badge.svg)

## Table of Contents

- [Introduction](#introduction)
- [Installation](#installation)
- [CLI Options](#options)

## Introduction

### What is this?

colors is a CLI that parse colors from text files. It can also convert colors between different formats. Currently the application supports parsing hexadecimals (without alpha) and converting them to RGB.

[![asciicast](https://asciinema.org/a/x5zbJ7nKf8DDilVgm1dy2oyWE.svg)](https://asciinema.org/a/x5zbJ7nKf8DDilVgm1dy2oyWE)

> ⚠️ As of version `0.0.2`, the output is in [Truecolor](https://en.wikipedia.org/wiki/Color_depth#True_color_(24-bit)) mode, so if the colors does not look right, it is very likely that your terminal does not support Truecolor. In the upcoming versions, we plan to let the user customize the output format. You can check a list of devices that support Truecolor [here](https://gist.github.com/XVilka/8346728#truecolor-support-in-output-devices).


## Installation

### Using npm

```console
npm i @mxthevs/colors -g
```

### Using yarn

```console
yarn global add @mxthevs/colors
```

## Usage

```console
colors /path/to/file.{txt,json,etc}
```

In case you already have a package or shell function named `colors` in your system (This might be the case if you are using zsh, for example. You can check this by running `type colors` in your terminal), you can still run this package with the command:

```console
npx @mxthevs/colors /path/to/file.{txt,json,etc}
```

## Options

You can check the help page for the full set of options that `colors` accept.

```
colors --help
```

Feel free to report any bug that you encounter! 😃
