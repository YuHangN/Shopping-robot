(define (problem shopbot_problem_with_basket)
    (:domain shopbot_supermarket_with_basket)
    
    (:objects
        cell1 cell2 cell3 cell4 cell5 cell6 cell7 cell8 cell9 cell10 cell11 cell12 cell13 cell14 cell15 cell16 cell17 cell18 cell19 cell20 - aisle_cell
        shelf1 shelf2 shelf3 shelf4 shelf5 shelf6 shelf7 shelf8 - shelf
        ice_lolly pizza bread ketchup toothpaste shampoo - non_produce
        cabbage potato - produce
        scale - weighing_scale
        checkout - checkout_stand
        basketloc - basketLoc
        bot - shopbot
        basket - Basket
    )

        (:init
            ;; Layout of supermarket.
            (adjacent cell1 cell2)
            (adjacent cell2 cell1)
            (adjacent cell2 cell3)
            (adjacent cell3 cell2)
            (adjacent cell3 cell5)
            (adjacent cell5 cell3)
            (adjacent cell5 cell6)
            (adjacent cell6 cell5)
            (adjacent cell5 cell12)
            (adjacent cell12 cell5)
            (adjacent cell6 cell7)
            (adjacent cell7 cell6)
            (adjacent cell7 cell8)
            (adjacent cell8 cell7)
            (adjacent cell8 cell13)
            (adjacent cell13 cell8)
            (adjacent cell13 cell18)
            (adjacent cell18 cell13)
            (adjacent cell18 cell20)
            (adjacent cell20 cell18)
            (adjacent cell19 cell20)
            (adjacent cell20 cell19)
            (adjacent cell19 cell17)
            (adjacent cell17 cell19)
            (adjacent cell17 cell18)
            (adjacent cell18 cell17)
            (adjacent cell17 cell16)
            (adjacent cell16 cell17)
            (adjacent cell16 cell15)
            (adjacent cell15 cell16)
            (adjacent cell15 cell12)
            (adjacent cell12 cell15)
            (adjacent cell11 cell12)
            (adjacent cell12 cell11)
            (adjacent cell10 cell11)
            (adjacent cell11 cell10)
            (adjacent cell9 cell10)
            (adjacent cell10 cell9)
            (adjacent cell4 cell9)
            (adjacent cell9 cell4)
            (adjacent cell9 cell14)
            (adjacent cell14 cell9)
            ;; Position of weighing_scale
            (adjacent cell1 scale)
            (adjacent scale cell1)
            (adjacent cell4 scale)
            (adjacent scale cell4)
            ;; Position of checkout
            (adjacent cell14 checkout) 
            ;; Position of shelf1 ice_lolly
            (adjacent cell3 shelf1)
            (adjacent cell6 shelf1)
            ;; Position of shelf2 pizza
            (adjacent cell7 shelf2)
            ;; Position of shelf3 cabbage
            (adjacent cell1 shelf3)
            (adjacent cell4 shelf3)
            (adjacent cell10 shelf3)
            ;; Positon of potato shelf4
            (adjacent cell5 shelf4)
            (adjacent cell11 shelf4)
            (adjacent cell2 shelf4)
            ;; Position of shelf5 toothpaste
            (adjacent cell6 shelf5)
            (adjacent cell12 shelf5)
            (adjacent cell16 shelf5)
            ;; Position of shelf6 shampoo
            (adjacent cell7 shelf6)
            (adjacent cell13 shelf6)
            (adjacent cell17 shelf6)
            ;; Position of shelf7 bread
            (adjacent cell10 shelf7)
            (adjacent cell14 shelf7)
            ;; Position of shelf8 ketchup
            (adjacent cell11 shelf8)
            (adjacent cell15 shelf8)
            ;; Position of basket
            (adjacent cell16 basketloc)
            (adjacent cell19 basketloc)

            ;; Position of robot
            (at_shopbot cell20)

            ;; Positon of items
            (at_item ice_lolly shelf1)
            (at_item pizza shelf2)
            (at_item cabbage shelf3)
            (at_item potato shelf4)
            (at_item toothpaste shelf5)
            (at_item shampoo shelf6)
            (at_item bread shelf7)
            (at_item ketchup shelf8)
            (basket_available basketloc)

            ;; Items needed weigh
            (weighable potato)
            (weighable cabbage)

            ;; Hold nothing
            (holding_nothing bot)
        )

        (:goal
            (and
                (checkedout potato)
                (checkedout ketchup)
                (checkedout toothpaste)
                (checkedout pizza))
        )
)
