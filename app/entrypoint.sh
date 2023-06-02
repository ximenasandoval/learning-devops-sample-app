#!/bin/bash

# Load env vars from Vault
python vault.py
export $(cat env | xargs)

# Start server
python server.py