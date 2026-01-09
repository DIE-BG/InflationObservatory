# Inflation Observatory

Inflation Observatory is an application developed in Julia and Genie Framework to visualize and analyze inflation data. It includes advanced integration examples, such as interactive visualizations with Makie.

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/DIE-BG/InflationObservatory.git
   ```
2. Install dependencies from the Julia REPL:
   ```julia
   import Pkg; Pkg.instantiate()
   ```

## Usage

To run the application locally:

```julia
using GenieFramework
Genie.loadapp()
up()
```

Open your browser at `http://localhost:8000`.

## Makie Integration Example

The project includes an example of how to integrate interactive Makie visualizations into Genie. You can find it at:

- `/src/apps/MakieExample/`