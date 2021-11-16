# Poker POC

## Approach

This is a "naive" or "basic" poker hand evaluator. I only added simple optimizations like memoizing methods. I mainly focused on clean code, test coverage, and accuracy.

If a highly efficient evaluator were desired, I would probably use [The Two Plus Two Evaluator](https://www.codingthewheel.com/archives/poker-hand-evaluator-roundup/#2p2).
## Assumptions

- 52 Card Deck
- 2 Players

## TODO

- Deal with ties better. I think the evaluator handles most ties except a Royal Flush tie, but the presentation doesn't address ties at all.
## Requirements

- Docker

## Clone

`git clone https://github.com/mlins/poker-poc.git`

`cd pocker-poc`
## Build

`docker build . -t poker-poc:latest`

## Run

`docker run -p 4567:4567 poker-poc:latest`

## Visit

http://127.0.0.1:4567/

## Tests

`docker run pocker-poc:latest rake test`

