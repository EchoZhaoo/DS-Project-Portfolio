# Santa Gift Matching Challenge

## Data Description 
- Out **goal** here is to build a toy matching algorithm that maximizes happiness by pairing kids with toys they want. 
- We have **two datasets** in this competition. One is called `child_wishlist`, which contains a list of 1,000,000 children and their wish lists of 100 gifts. Another one is called `gift_goodkids`, which is a list of 1000 gifts, and their list of 1000 good kids that they prefer to give to.
- Both the kids and Santa need to be happy - for kids, the higher the gift is on their wish list, the happier, for Santa and his gifts, the higher the child is on the good kids list, the happier Santa is.
- **Constrains**: 
  - 0.5% children are triplets (5000), who need to be given the same gift even though they might have different preferences.
  - 4% children are twins (40000), who also need to be given the same gift even though they might have different preferences.


## Feature engineering
- Treat all the triplets as three kids with same preferences on gifts, where the unique wishlist was picked from one of the triplets.
- Treat all the twins as two kids with same preferences, where the unique wishlist was picked from one of the twins.
- Did some approximation of the given evaluatio model for total happiness for easier computing.
- Only considered the first 60 gifts on the kids' wishlist because of the limited computing resource.
- Only take the cases that both children and gifts are interested to each other, discared all the rest cases.



## Modeling
- It turned out to be a **Min-Cost Flow Problem**
- The graph here is a bipartite graph, one node set presents all the gifts, the other node set presents all the children.
- The edges only exits between gift node set and child node set, there is no edge inside the gift node set or the child node set.
- The weight on each edge is the rank on the wishlist.
- Did linear approximation of the of the original object function, which is (ANCH)^3 + (ANSH)^3. (ANCH: Average Normalized Child Happiness; ANSH: Average Normalized Santa Happiness).
- Cut the edges whose ChildHappinesses are less than 100.
- Used `Ortools` to solve this Min-Cost Flow Problem
- Used `SolveMaxFlowWithMinCost()` as a relexation, which means some gifts may be left unassigned or some kids might have no gift.
- For some twins and triplets having different gifts (which is 2 tripets and 42 twins in out final result), we swap their gifts with singes to make triplets and twins satifying their constraints.

## Result
Out result is around **0.9287**.
