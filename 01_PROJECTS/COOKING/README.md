# COOKING Project

A personal cooking knowledge base with recipes, techniques, and AI-assisted recipe management.

## Structure

```
COOKING/
├── .claude/
│   ├── agents/
│   │   └── cooking-assistant.md    # Specialized cooking agent configuration
│   └── skills/
│       └── scale-recipe.md         # Recipe scaling skill
├── Turkey/                          # Holiday turkey recipes
│   ├── bettyC_stuffing.md
│   ├── bettyC_turkey.md
│   └── sources.md
└── README.md                        # This file
```

## Using the Cooking Agent

### Method 1: Direct Request
Simply ask Claude Code to help with cooking tasks while in this directory:
- "Scale this recipe for X servings"
- "Convert 500g flour to cups"
- "What can I substitute for eggs in this recipe?"
- "Create a recipe file for my grandmother's soup"

### Method 2: Using Skills (Future)
Once skills are enabled, you can use:
```bash
/scale-recipe Turkey/bettyC_stuffing.md 70
```

### Method 3: Reference the Agent
When working on complex cooking tasks:
```
@.claude/agents/cooking-assistant.md help me plan a meal for 20 people
```

## Recipe File Format

All recipes should follow this standard format:

```markdown
# Recipe Name

**Prep Time:** X min
**Cook Time:** X min
**Total Time:** X min
**Servings:** X

## Ingredients

- quantity measurement ingredient
- quantity measurement ingredient

## Instructions

1. Step with clear action
2. Step with timing
3. Step with temperature

## Notes

- Storage tips
- Make-ahead options
- Substitutions
```

## Common Tasks

### Scaling Recipes
The agent can scale recipes based on:
- **Servings:** "Scale for 12 servings"
- **Ingredient quantity:** "Scale for 88 bread slices"
- **Pan size:** "Scale to fit a 9x13 pan"

### Converting Measurements
- Metric ↔ Imperial
- Weight ↔ Volume
- Practical equivalents (e.g., "3 teaspoons = 1 tablespoon")

### Organizing Recipes
- Extract recipes from websites or images
- Format existing recipes to standard structure
- Add metadata (prep time, servings, categories)

### Meal Planning
- Calculate ingredients for multiple recipes
- Batch cooking quantities
- Make-ahead preparation schedules

## Recipe Sources

Attribution format:
- `bettyC_*.md` - Betty Crocker recipes
- `sources.md` - Recipe source documentation

## Quick Reference: Common Conversions

### Volume
- 3 teaspoons = 1 tablespoon
- 16 tablespoons = 1 cup
- 2 cups = 1 pint
- 4 cups = 1 quart
- 4 quarts = 1 gallon

### Weight (Butter)
- 1 stick = 1/2 cup = 1/4 pound = 113g
- 2 sticks = 1 cup = 1/2 pound = 227g
- 4 sticks = 2 cups = 1 pound = 454g

### Common Ingredients (approximate)
- 1 cup all-purpose flour = 120-125g
- 1 cup granulated sugar = 200g
- 1 cup butter = 227g
- 1 cup water = 240ml

## Tips for Working with the Agent

1. **Be specific about scaling target**
   - Good: "Scale for 70 slices"
   - Less specific: "Make it bigger"

2. **Provide context for substitutions**
   - "I'm allergic to eggs" vs "I don't have eggs"
   - Different solutions for dietary vs availability

3. **Mention equipment constraints**
   - "I only have one oven"
   - "Limited to 9x13 pans"

4. **Ask about timing**
   - "Can this be made ahead?"
   - "What order should I prep ingredients?"

## Future Enhancements

- [ ] Recipe tagging system (dietary restrictions, cuisine type, difficulty)
- [ ] Nutrition calculation integration
- [ ] Shopping list generator from multiple recipes
- [ ] Seasonal ingredient suggestions
- [ ] Wine pairing recommendations
- [ ] Recipe search by ingredients on hand
