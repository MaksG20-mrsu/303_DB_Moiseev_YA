#!/bin/bash
python main.py
./sqlite3.exe movies_rating.db < db_init.sql
