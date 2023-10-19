tags: #azure
title: IoT Edge
description: The Azure service I like the most

IoT Edge
========

Restart module
--------------

    az iot hub invoke-module-method --method-name 'RestartModule' -n <hub name> -d <device name> -m '$edgeAgent' --method-payload \
    '
        {
            "schemaVersion": "1.0",
            "id": "<module name>"
        }
    '
