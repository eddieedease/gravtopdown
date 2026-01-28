# Dialogue System Documentation

This project uses a data-driven dialogue system managed by `DialogueManager` (Autoload).

## Overview

*   **Data Source**: `res://data/dialogue.json`
*   **Manager**: `res://scripts/dialogue_manager.gd`
*   **UI**: `res://scenes/dialogue_box.tscn`
*   **NPCs**: Any node in group `interactable` with an `interact()` method (e.g., `res://scenes/npc.tscn`).

## How to Add New Dialogue

1.  Open `res://data/dialogue.json`.
2.  Add a new key-value pair. The key is the **NPC ID**, and the value is an array of strings (lines of text).

```json
{
    "npc_blacksmith": [
        "Welcome to the forge!",
        "I can fix anything."
    ]
}
```

## How to Create a New NPC

1.  Instance `scenes/npc.tscn` in your world.
2.  Select the NPC node.
3.  In the Inspector, set the **Npc Id** export variable to match the key in your JSON (e.g., `npc_blacksmith`).
4.  Ensure the NPC is in the `interactable` group (the default scene is already in this group).

## How it Works

1.  **Player Interaction**:
    *   The Player has a `RayCast2D` handling interaction.
    *   When `ui_accept` (Space) is pressed, it checks for collision with an `interactable` object.
    *   Calls `collider.interact()` if found.
2.  **Dialogue Flow**:
    *   `DialogueManager.start_dialogue(id)` is called.
    *   It pauses player movement (`DialogueManager.is_dialogue_active`).
    *   Shows the UI overlay.
    *   Pressing `ui_accept` advances text.
    *   When finished, movement resumes.
