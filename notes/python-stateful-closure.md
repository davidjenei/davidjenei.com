tags: #python
title: Stateful closure
description: Functions with stateful closures

# Stateful closure

Harder to read, but fits function first API design.

	def increment_with_report(current, increments):
	    added_count = 0
	    def missing():
	        nonlocal added_count  # Stateful closure
            added_count += 1
        return 0

    result = defaultdict(missing, current)
    for key, amount in increments:
	    result[key] += amount
	return result, added_count”

