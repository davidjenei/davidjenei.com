title: Set
tags: #python

Set
===

    pantry = {"Flour", "Sugar", "Eggs", "Milk", "Butter"}

Practices
---------

1.  Removing duplications

         recipe_ingredients_array = ["Flour", "Sugar", "Eggs", "Milk", "Butter", "Sugar"]
         unique_ingredients_set = set(recipe_ingredients_array)

2.  Set operations

         pantry = {"Flour", "Sugar", "Eggs", "Milk", "Butter"}
         recipe = {"Sugar", "Eggs", "Chocolate", "Butter"}

         shopping_list = recipe - pantry

3.  Efficient membership testing

         time python3 -c "data = list(range(1000000)); membership_checks = [i in data for i in range(10000)]"

Recipe: Things that are sets
-------------------------------

I noticed that I underestimate the power of sets. Here are some examples
where using a set makes sense:

-   book genres
-   tags for a blog post
-   ingredients for a recipe
-   user permissions
-   available colors for a palette
-   playing card suits

If you see any of this:

-   genre
-   category
-   tag
-   feature
-   unique

There is a chance that representing as a set can help.

  [Set]: #set
  [Practices]: #practices
  [Recipe: Things that can be sets]: #recipe-things-that-can-be-sets
