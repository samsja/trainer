# Trainer

strip off version of the [prime](https://github.com/primeIntellect-ai/prime) framework


## install

quick install
```
curl -sSL https://raw.githubusercontent.com/samsja/trainer/main/scripts/install/install.sh | bash
```

long install


1. Clone: 

```bash
git clone git@github.com:PrimeIntellect-ai/prime-rl.git
cd prime-rl
```

2. Install `uv`:

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
source $HOME/.local/bin/env
```

3. Set up the environment:
```bash
uv venv --python 3.10
source .venv/bin/activate
uv sync
```

## Train

### debug run 

```bash
uv run torchrun --nproc_per_node=2 src/zeroband/train.py @ configs/debug/normal.toml
```

### run on 8xH100

150M
```bash
uv run torchrun --nproc_per_node=2 src/zeroband/train.py @ configs/150M/H100.toml
```

1B
```bash
uv run torchrun --nproc_per_node=2 src/zeroband/train.py @ configs/1B/H100.toml
```


## Dev

 Precommit install

```bash
uv pre-commit install
```

 Test

```bash
uv run pytest
```




