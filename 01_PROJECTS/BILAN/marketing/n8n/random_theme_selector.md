# BILAN Random Theme Selector - Complete Implementation

## Overview
JavaScript function for randomly selecting content themes from BILAN's comprehensive marketing materials. Designed for n8n Function nodes.

## Implementation Options

### Option 1: Complete Function (Recommended for n8n)
```javascript
// BILAN Random Theme Selector Function
// Copy this entire code into an n8n Function node

const bilanThemeSelector = {
  // Educational content themes
  educational: [
    {
      theme: "What Are Electrolytes?",
      focus: "Basic electrolyte education",
      keywords: ["electrolytes", "hydration", "minerals", "body function"],
      content_angle: "Educational foundation post",
      call_to_action: "Learn more about electrolyte balance"
    },
    {
      theme: "The Role of Electrolytes in Hydration",
      focus: "Hydration science",
      keywords: ["hydration", "water balance", "fluid retention", "cellular hydration"],
      content_angle: "Science-based explanation",
      call_to_action: "Discover optimal hydration strategies"
    },
    {
      theme: "Electrolytes for Performance and Recovery",
      focus: "Athletic performance",
      keywords: ["performance", "recovery", "athletics", "endurance", "muscle function"],
      content_angle: "Athletic performance focus",
      call_to_action: "Elevate your performance with proper electrolytes"
    },
    {
      theme: "Sodium: The Misunderstood Electrolyte",
      focus: "Sodium education",
      keywords: ["sodium", "salt", "blood pressure", "essential mineral"],
      content_angle: "Myth-busting content",
      call_to_action: "Understand sodium's role in health"
    },
    {
      theme: "Potassium: The Heart Mineral",
      focus: "Potassium benefits",
      keywords: ["potassium", "heart health", "muscle cramps", "nervous system"],
      content_angle: "Heart health emphasis",
      call_to_action: "Support your heart with potassium"
    },
    {
      theme: "Magnesium: The Relaxation Mineral",
      focus: "Magnesium benefits",
      keywords: ["magnesium", "relaxation", "sleep", "muscle recovery", "stress"],
      content_angle: "Wellness and recovery focus",
      call_to_action: "Find calm with proper magnesium"
    }
  ],

  // Brand pillar themes
  brand_pillars: [
    {
      theme: "Euhidratación y Equilibrio",
      focus: "Superior hydration concept",
      keywords: ["euhidratación", "balance", "optimal hydration", "electrolyte balance"],
      content_angle: "Premium positioning",
      call_to_action: "Experience superior hydration with BILAN"
    },
    {
      theme: "La Batería Humana",
      focus: "Body as battery analogy",
      keywords: ["batería", "energy", "cellular energy", "power", "vitality"],
      content_angle: "Energy and power metaphor",
      call_to_action: "Power your human battery with BILAN"
    },
    {
      theme: "Pureza y Calidad Científica",
      focus: "Scientific purity",
      keywords: ["pureza", "calidad", "científico", "libre de aditivos", "evidencia"],
      content_angle: "Scientific credibility",
      call_to_action: "Trust the science behind BILAN"
    },
    {
      theme: "La Alternativa Pura",
      focus: "Clean alternative to sugary drinks",
      keywords: ["alternativa", "sin azúcar", "limpio", "natural", "saludable"],
      content_angle: "Clean comparison",
      call_to_action: "Choose the pure alternative - BILAN"
    }
  ],

  // Seasonal content themes
  seasonal: [
    {
      theme: "Summer Hydration Essentials",
      focus: "Hot weather hydration",
      keywords: ["verano", "calor", "deshidratación", "clima cálido", "sol"],
      content_angle: "Seasonal relevance",
      call_to_action: "Stay hydrated all summer with BILAN"
    },
    {
      theme: "Winter Indoor Hydration",
      focus: "Cold weather hydration",
      keywords: ["invierno", "calefacción", "clima seco", "interior", "humedad"],
      content_angle: "Year-round necessity",
      call_to_action: "Don't forget winter hydration with BILAN"
    },
    {
      theme: "Holiday Health & Hydration",
      focus: "Seasonal wellness",
      keywords: ["fiestas", "salud", "celebración", "equilibrio", "moderación"],
      content_angle: "Holiday wellness",
      call_to_action: "Maintain balance during holidays with BILAN"
    },
    {
      theme: "Spring Renewal & Detox",
      focus: "Seasonal cleansing",
      keywords: ["primavera", "renovación", "desintoxicación", "limpieza", "nuevo inicio"],
      content_angle: "Fresh start theme",
      call_to_action: "Renew your health this spring with BILAN"
    },
    {
      theme: "Fall Performance & Recovery",
      focus: "Seasonal athletic focus",
      keywords: ["otoño", "rendimiento", "recuperación", "deportes", "entrenamiento"],
      content_angle: "Athletic preparation",
      call_to_action: "Boost fall performance with BILAN"
    }
  ],

  // Product-focused themes
  product_focus: [
    {
      theme: "BILAN vs Sports Drinks",
      focus: "Product comparison",
      keywords: ["comparación", "bebidas deportivas", "azúcar", "aditivos", "limpio"],
      content_angle: "Competitive differentiation",
      call_to_action: "See why BILAN beats sports drinks"
    },
    {
      theme: "The Science Behind BILAN",
      focus: "Product formulation",
      keywords: ["ciencia", "formulación", "ingredientes", "investigación", "eficacia"],
      content_angle: "Scientific validation",
      call_to_action: "Discover the science in every BILAN serving"
    },
    {
      theme: "How to Use BILAN Daily",
      focus: "Usage instructions",
      keywords: ["cómo usar", "dosificación", "diario", "rutina", "mejor momento"],
      content_angle: "Practical guidance",
      call_to_action: "Optimize your daily routine with BILAN"
    },
    {
      theme: "BILAN for Different Lifestyles",
      focus: "Target audience segments",
      keywords: ["estilos de vida", "atletas", "profesionales", "padres", "estudiantes"],
      content_angle: "Audience segmentation",
      call_to_action: "Find your perfect BILAN routine"
    }
  ],

  // Health and wellness themes
  health_wellness: [
    {
      theme: "Electrolytes and Mental Focus",
      focus: "Cognitive benefits",
      keywords: ["concentración", "enfoque", "cerebro", "función cognitiva", "claridad mental"],
      content_angle: "Mental performance",
      call_to_action: "Sharpen your focus with BILAN"
    },
    {
      theme: "Hydration for Skin Health",
      focus: "Beauty benefits",
      keywords: ["piel", "belleza", "hidratación", "salud cutánea", "anti-envejecimiento"],
      content_angle: "Beauty and wellness",
      call_to_action: "Nourish your skin from within with BILAN"
    },
    {
      theme: "Electrolytes for Better Sleep",
      focus: "Sleep quality",
      keywords: ["sueño", "descanso", "calidad del sueño", "recuperación nocturna", "relajación"],
      content_angle: "Sleep optimization",
      call_to_action: "Enhance your sleep with BILAN"
    },
    {
      theme: "Immune Support Through Hydration",
      focus: "Immune system benefits",
      keywords: ["sistema inmune", "defensas", "salud", "protección", "resistencia"],
      content_angle: "Health protection",
      call_to_action: "Support your immune system with BILAN"
    }
  ],

  // Lifestyle themes
  lifestyle: [
    {
      theme: "Office Hydration Habits",
      focus: "Workplace wellness",
      keywords: ["oficina", "trabajo", "productividad", "enfoque laboral", "rutina diaria"],
      content_angle: "Professional productivity",
      call_to_action: "Boost workplace performance with BILAN"
    },
    {
      theme: "Travel Hydration Tips",
      focus: "Travel wellness",
      keywords: ["viaje", "avión", "deshidratación", "jet lag", "energía"],
      content_angle: "Travel preparation",
      call_to_action: "Travel smarter with BILAN hydration"
    },
    {
      theme: "Family Hydration Health",
      focus: "Family wellness",
      keywords: ["familia", "niños", "salud familiar", "hábitos saludables", "bienestar"],
      content_angle: "Family health focus",
      call_to_action: "Keep your family healthy with BILAN"
    },
    {
      theme: "Weekend Warrior Recovery",
      focus: "Recreational athletics",
      keywords: ["fin de semana", "guerrero", "recuperación", "actividad", "energía"],
      content_angle: "Weekend activity support",
      call_to_action: "Conquer your weekends with BILAN"
    }
  ]
};

// Random selection function with weighted categories
function selectRandomTheme() {
  // Category weights (adjust based on your content strategy)
  const categoryWeights = {
    educational: 25,      // 25% educational content
    brand_pillars: 20,    // 20% brand pillar reinforcement
    seasonal: 15,         // 15% seasonal content
    product_focus: 15,    // 15% product-specific content
    health_wellness: 15,  // 15% health and wellness
    lifestyle: 10         // 10% lifestyle content
  };

  // Calculate weighted random selection
  const totalWeight = Object.values(categoryWeights).reduce((a, b) => a + b, 0);
  let random = Math.random() * totalWeight;
  
  let selectedCategory = null;
  for (const [category, weight] of Object.entries(categoryWeights)) {
    random -= weight;
    if (random <= 0) {
      selectedCategory = category;
      break;
    }
  }

  // Fallback to random category if weighted selection fails
  if (!selectedCategory) {
    const categories = Object.keys(bilanThemeSelector);
    selectedCategory = categories[Math.floor(Math.random() * categories.length)];
  }

  // Select random theme from chosen category
  const themesInCategory = bilanThemeSelector[selectedCategory];
  const selectedTheme = themesInCategory[Math.floor(Math.random() * themesInCategory.length)];
  
  // Generate additional metadata
  const timestamp = new Date().toISOString();
  const contentId = `bilan_${Date.now()}`;
  
  return {
    ...selectedTheme,
    category: selectedCategory,
    content_id: contentId,
    selected_at: timestamp,
    prompt_context: `Create social media content about: ${selectedTheme.theme}. Focus: ${selectedTheme.focus}. Content angle: ${selectedTheme.content_angle}. Call to action: ${selectedTheme.call_to_action}. Include keywords: ${selectedTheme.keywords.join(', ')}. Category: ${selectedCategory}.`,
    metadata: {
      total_themes_in_category: themesInCategory.length,
      category_weight: categoryWeights[selectedCategory],
      selection_method: 'weighted_random'
    }
  };
}

// Execute selection and format for n8n output
const selectedTheme = selectRandomTheme();

// Return formatted output for next node
return [{
  json: {
    // Core theme data
    theme: selectedTheme.theme,
    focus: selectedTheme.focus,
    keywords: selectedTheme.keywords,
    category: selectedTheme.category,
    content_angle: selectedTheme.content_angle,
    call_to_action: selectedTheme.call_to_action,
    
    // Metadata
    content_id: selectedTheme.content_id,
    selected_at: selectedTheme.selected_at,
    prompt_context: selectedTheme.prompt_context,
    
    // Additional context for AI
    ai_prompt_enhancement: {
      brand_voice: "authoritative yet accessible, scientific but empowering",
      target_audience: "health-conscious individuals, athletes, professionals",
      content_goals: ["educate", "inspire", "build trust", "drive engagement"],
      tone_guidelines: ["evidence-based", "empowering", "approachable", "professional"],
      hashtag_strategy: "mix of broad health terms and specific electrolyte keywords"
    },
    
    // Selection metadata
    selection_metadata: selectedTheme.metadata
  }
}];
```

### Option 2: Simple Version (Basic Function)
```javascript
// Simple BILAN Theme Selector
// For basic n8n Function nodes

const themes = [
  "What Are Electrolytes?",
  "The Role of Electrolytes in Hydration", 
  "Electrolytes for Performance and Recovery",
  "Euhidratación y Equilibrio",
  "La Batería Humana",
  "Pureza y Calidad Científica",
  "La Alternativa Pura",
  "Summer Hydration Essentials",
  "BILAN vs Sports Drinks",
  "The Science Behind BILAN"
];

const randomTheme = themes[Math.floor(Math.random() * themes.length)];

return [{
  json: {
    theme: randomTheme,
    content_id: `bilan_${Date.now()}`,
    selected_at: new Date().toISOString(),
    prompt_context: `Create social media content about: ${randomTheme}`
  }
}];
```

## How to Use in n8n

### Step 1: Create Function Node
1. Add **Function** node to your workflow
2. Name it: "Random Theme Selector"
3. Copy and paste the complete function code (Option 1 recommended)

### Step 2: Connect to Workflow
- Connect **Schedule Trigger** → **Theme Selector** → **Claude API**
- The theme selector output will feed directly into your AI content generation

### Step 3: Test the Function
1. Execute the workflow manually
2. Check the output JSON structure
3. Verify random selection is working
4. Confirm all data fields are populated

## Expected Output Structure

```json
{
  "theme": "What Are Electrolytes?",
  "focus": "Basic electrolyte education", 
  "keywords": ["electrolytes", "hydration", "minerals", "body function"],
  "category": "educational",
  "content_angle": "Educational foundation post",
  "call_to_action": "Learn more about electrolyte balance",
  "content_id": "bilan_1642234567890",
  "selected_at": "2025-01-15T09:00:00Z",
  "prompt_context": "Create social media content about: What Are Electrolytes?. Focus: Basic electrolyte education. Content angle: Educational foundation post. Call to action: Learn more about electrolyte balance. Include keywords: electrolytes, hydration, minerals, body function. Category: educational.",
  "ai_prompt_enhancement": {
    "brand_voice": "authoritative yet accessible, scientific but empowering",
    "target_audience": "health-conscious individuals, athletes, professionals",
    "content_goals": ["educate", "inspire", "build trust", "drive engagement"],
    "tone_guidelines": ["evidence-based", "empowering", "approachable", "professional"],
    "hashtag_strategy": "mix of broad health terms and specific electrolyte keywords"
  },
  "selection_metadata": {
    "total_themes_in_category": 6,
    "category_weight": 25,
    "selection_method": "weighted_random"
  }
}
```

## Customization Options

### Adjust Category Weights
```javascript
// Modify these weights in the function
const categoryWeights = {
  educational: 30,      // Increase educational content
  brand_pillars: 25,    // More brand reinforcement
  seasonal: 10,         // Less seasonal content
  product_focus: 15,    // Keep product focus
  health_wellness: 15,  // Keep health content
  lifestyle: 5          // Reduce lifestyle content
};
```

### Add New Themes
```javascript
// Add to any category in the themes array
{
  theme: "Your New Theme",
  focus: "Theme focus description",
  keywords: ["keyword1", "keyword2", "keyword3"],
  content_angle: "How to approach this topic",
  call_to_action: "Desired action from audience"
}
```

### Seasonal Theme Filtering
```javascript
// Add seasonal filtering at the beginning of selectRandomTheme()
function selectRandomTheme() {
  const currentMonth = new Date().getMonth();
  const seasonalThemes = {
    spring: [3, 4, 5],    // March, April, May
    summer: [6, 7, 8],    // June, July, August  
    fall: [9, 10, 11],   // September, October, November
    winter: [0, 1, 2]    // January, February, December
  };
  
  // Filter seasonal themes based on current month
  // ... (add seasonal logic here)
}
```

## Testing Your Theme Selector

### Manual Testing
```javascript
// Test multiple selections in browser console
for(let i = 0; i < 10; i++) {
  console.log(selectRandomTheme().theme);
}
```

### Category Distribution Test
```javascript
// Test category distribution over 100 selections
const distribution = {};
for(let i = 0; i < 100; i++) {
  const category = selectRandomTheme().category;
  distribution[category] = (distribution[category] || 0) + 1;
}
console.log(distribution);
```

This theme selector provides comprehensive variety while maintaining BILAN's brand consistency and content strategy goals.