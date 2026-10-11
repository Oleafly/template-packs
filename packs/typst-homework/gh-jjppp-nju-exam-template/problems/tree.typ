#import "../template/common.typ": *

= Trees

*This problem is based on the assumption that all labels in a tree are different positive numbers.*

#block(
  columns(
    2,
    [
      #block([
        The following tree APIs are available for this problem:
        - `tree(label, branches=[])`
        - `label(tree)`
        - `branches(tree)`
        - `is_leaf(tree)`
        - When printing a tree, you will get a string that, when executed, construct the same tree.
      ])
      #colbreak()
      #align(
        center,
        block(
          tree((
            [1],
            (
              [2],
              [3],
              (
                [4],
                [5],
                [6],
              ),
            ),
            [7],
          )),
        ),
      )
    ],
  ),
)

Define the tree in the figure using `tree` constructor.

#code_block(```python
t1 = #{{tree(1, [tree(2, [tree(3), tree(4, [tree(5), tree(6)])]), tree(7)])@3}}
```)

#comment[自第1层（2/7节点所在层）开始，写对一层给1分。]


Implement `count_leaves`, which takes in a tree and count the number of its leaves.

#code_block(```python
def count_leaves(t):
    """ Returns the number of leaves in this tree.
    >>> count_leaves(t1) # 3, 7, 5, 6
    4
    """
    if #{{is_leaf(t)@1}}:
        return 1
    else:
        return sum(#{{[count_leaves(b) for b in branches(t)]@2}})
```)

Implement `add_one`, which takes in a tree and returns a new tree with each node's label is the corresponding node in original tree's label plus one.

#code_block(```python
def add_one(t):
    """ Returns a new tree, with 1 added to each node.
    >>> add_one(t1)
    tree(2, [tree(3, [tree(4), tree(5, [tree(6), tree(7)])]), tree(8)])
    """
    return tree(
        #{{label(t) + 1@1}},
        #{{[add_one(b) for b in branches(t)]@3}}
    )
```)

Implement `count_leaves_at_depth`, which counts how many leaves are there in a tree with given depth.

The depth of a node is defined as follows:
- If it is the root, its depth is 0.
- Otherwise, its depth is the depth of its parent plus one.
#code_block(```python
def count_leaves_at_depth(t,depth):
    """ Return the number of leaves at depth.
    >>> count_leaves_at_depth(t1,1) # 7
    1
    """
    def helper(t,current_depth):
        if current_depth==depth:
            if (#{{is_leaf(t)@1}}):
                return 1
            return 0
        leaves = #{{[helper(b, current_depth + 1) for b in branches(t)]@3}}
        return sum(leaves)
    return #{{helper(t,0)@1}}
```)

Implement `sum_sub_trees`, which takes in a tree `t` and returns a new tree of the same shape but with new labels. Each new label sums up the old label of the same node and all the old labels in the sub-trees of this node (by old label we mean the label in the old tree). (5pts)

For example, when calculating `sum_sub_tree` for `t1`, we would get this result. Here, $20 = 2 + 3 + 4 + 5 + 6$.

#block(
  columns(
    2,
    [#align(
        center,
        tree((
          [1],
          (
            [2],
            [3],
            (
              [4],
              [5],
              [6],
            ),
          ),
          [7],
        )),
      )
      #colbreak()
      #align(
        center,
        tree((
          [28],
          (
            [20],
            [3],
            (
              [15],
              [5],
              [6],
            ),
          ),
          [7],
        )),
      )
    ],
  ),
)


#code_block(```python
def sum_sub_trees(t):
    """ Returns a new tree, with each node's label replaced by the sum of
    that sub tree.
    >>> sum_sub_trees(t1)
    tree(28, [tree(20, [tree(3), tree(15, [tree(5), tree(6)])]), tree(7)])
    """
    added = [#{{sum_sub_trees(i)@1}} for i in branches(t)]
    return tree(
        #{{label(t) + sum([label(i) for i in added])@3}},
        #{{added@1}}
    )
```)

Implement `find_node`, which takes a tree `t` and a label value `v`, finds the node in `t` with the same label, and returns the sub-tree of `t` whose root is this node.
If no such node is found, `find_node` returns `None`.

#code_block(```python
def find_node(t, v):
    """ Returns the node with given label value.
    >>> find_node(t1, 3)
    tree(3)
    """
    if #{{label(t) == v@1}}:
        return t
    else:
        findings = [#{{find_node(b, v)@2}} for b in branches(t)]
    for f in findings:
        if f:
            return f
    return None
```)

#pagebreak()
