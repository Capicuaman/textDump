# Scale Recipe Skill

## Description
Quickly scale a recipe to a different number of servings or base quantity.

## Usage
- `/scale-recipe [recipe-file] [target-servings]`
- Example: `/scale-recipe Turkey/bettyC_stuffing.md 70`

## What This Skill Does
1. Reads the specified recipe file
2. Identifies the original serving size/quantity
3. Calculates the scaling factor
4. Provides scaled ingredients with practical measurements
5. Adjusts instructions and notes equipment needs

## Agent Instructions

When this skill is invoked:

1. **Read the recipe file** using the file path provided
2. **Identify base quantity** - Look for servings, yield, or specific ingredient quantities
3. **Calculate scaling factor** - Target ÷ Original
4. **Scale all ingredients** precisely
5. **Format output** with:
   - Clear scaling factor statement
   - Ingredient list with practical measurements
   - Instructions with adjustments noted
   - Equipment and batch notes

### Scaling Rules
- Round to practical measurements (nearest 1/4 tsp, 1/2 cup, etc.)
- Provide weight equivalents for large quantities of butter, flour, etc.
- Give ranges for imprecise ingredients (vegetables, garnishes)
- Note when multiple pans/batches are needed
- Warn about non-linear scaling (leavening, cooking times)

### Output Format
```
**Scaling factor:** X ÷ Y = Z×

## [Recipe Name] (Scaled for [target])

### Ingredients
- **bold quantity** ingredient (weight equivalent if applicable)

### Instructions
1. Adjusted instruction with equipment notes

**Note:** Equipment needs and batch suggestions
```

## Examples

### Example 1: Scale by servings
Input: `/scale-recipe Turkey/bettyC_stuffing.md 70`
- Reads file, finds "15 slices" base
- Calculates 70 ÷ 15 = 4.67×
- Scales all ingredients
- Notes: needs 4-5 baking dishes

### Example 2: Scale by ingredient
Input: `/scale-recipe chicken_stock.md 24-cups`
- Identifies base yield
- Scales to target yield
- Adjusts cooking times
