(define (problem hard_shopbot_problem)
    (:domain shopbot_supermarket)
    
    (:objects
        cell1 cell2 cell3 cell4 cell5 cell6 cell7 cell8 cell9 cell10 cell11 
        cell12 cell13 cell14 cell15 cell16 cell17 cell18 cell19 cell20 cell21
        cell22 cell23 cell24 cell25 cell26 cell27 cell28 cell29 cell30 cell31
        cell32 cell33 cell34 cell35 cell36 cell37 cell38 cell39 cell40 cell41
        cell42 cell43 cell45 cell46 cell47 cell48 cell49 cell50 cell51 - aisle_cell
        shelf1 shelf2 shelf3 shelf4 shelf5 shelf6 shelf7 shelf8 - shelf
        ice_lolly pizza ketchup toothpaste shampoo - non_produce
        cabbage potato bread - produce
        scale1 scale2 - weighing_scale
        checkout - checkout_stand
        bot - shopbot
    )

        (:init
            ;; Layout of supermarket.
            (adjacent cell1 cell2)
            (adjacent cell2 cell1)
            (adjacent cell2 cell3)
            (adjacent cell3 cell2)
            (adjacent cell3 cell4)
            (adjacent cell4 cell3)
            (adjacent cell4 cell5)
            (adjacent cell5 cell4)
            (adjacent cell5 cell6)
            (adjacent cell6 cell5)
            (adjacent cell6 cell7)
            (adjacent cell7 cell6)
            (adjacent cell7 cell8)
            (adjacent cell8 cell7)
            (adjacent cell8 cell9)
            (adjacent cell9 cell8)
            (adjacent cell9 cell10)
            (adjacent cell10 cell9)
            (adjacent cell10 cell11)
            (adjacent cell11 cell10)
            (adjacent cell11 cell12)
            (adjacent cell12 cell11)
            (adjacent cell12 cell13)
            (adjacent cell13 cell12)
            (adjacent cell13 cell14)
            (adjacent cell14 cell13)
            (adjacent cell11 cell26)
            (adjacent cell26 cell11)
            (adjacent cell26 cell27)
            (adjacent cell27 cell26)
            (adjacent cell27 cell28)
            (adjacent cell28 cell27)
            (adjacent cell28 cell29)
            (adjacent cell29 cell28)
            (adjacent cell29 cell30)
            (adjacent cell30 cell29)
            (adjacent cell30 cell31)
            (adjacent cell31 cell30)
            (adjacent cell31 cell32)
            (adjacent cell32 cell31)
            (adjacent cell32 cell33)
            (adjacent cell33 cell32)
            (adjacent cell33 cell34)
            (adjacent cell34 cell33)
            (adjacent cell34 cell35)
            (adjacent cell35 cell34)
            (adjacent cell35 cell36)
            (adjacent cell36 cell35)
            (adjacent cell36 cell45)
            (adjacent cell45 cell36)
            (adjacent cell45 cell46)
            (adjacent cell46 cell45)
            (adjacent cell46 cell47)
            (adjacent cell47 cell46)
            (adjacent cell47 cell48)
            (adjacent cell48 cell47)
            (adjacent cell48 cell49)
            (adjacent cell49 cell48)
            (adjacent cell49 cell50)
            (adjacent cell50 cell49)
            (adjacent cell50 cell51)
            (adjacent cell51 cell50)
            (adjacent cell36 cell37)
            (adjacent cell37 cell36)
            (adjacent cell37 cell38)
            (adjacent cell38 cell37)
            (adjacent cell38 cell39)
            (adjacent cell39 cell38)
            (adjacent cell39 cell40)
            (adjacent cell40 cell39)
            (adjacent cell40 cell41)
            (adjacent cell41 cell40)
            (adjacent cell41 cell42)
            (adjacent cell42 cell41)
            (adjacent cell42 cell43)
            (adjacent cell43 cell42)
            (adjacent cell12 cell15)
            (adjacent cell15 cell12)
            (adjacent cell15 cell16)
            (adjacent cell16 cell15)
            (adjacent cell16 cell17)
            (adjacent cell17 cell16)
            (adjacent cell17 cell18)
            (adjacent cell18 cell17)
            (adjacent cell18 cell19)
            (adjacent cell19 cell18)
            (adjacent cell19 cell20)
            (adjacent cell20 cell19)
            (adjacent cell20 cell21)
            (adjacent cell21 cell20)
            (adjacent cell21 cell22)
            (adjacent cell22 cell21)
            (adjacent cell22 cell23)
            (adjacent cell23 cell22)
            (adjacent cell23 cell24)
            (adjacent cell24 cell23)
            (adjacent cell24 cell25)
            (adjacent cell25 cell24)
            (adjacent cell28 cell35)
            (adjacent cell35 cell28)
            (adjacent cell12 cell15)
            (adjacent cell15 cell12)

            ;; Position of weighing_scale
            (adjacent cell51 scale1)
            (adjacent cell7 scale2)
            ;; Position of checkout
            (adjacent cell43 checkout) 
            ;; Position of ice_lolly
            (adjacent cell23 shelf1)
            ;; Position of pizza
            (adjacent cell24 shelf2)
            ;; Position of cabbage
            (adjacent cell25 shelf3)
            ;; Positon of potato
            (adjacent cell25 shelf4)
            ;; Position of toothpaste
            (adjacent cell43 shelf5)
            ;; Position of shampoo
            (adjacent cell42 shelf6)
            ;; Position of bread
            (adjacent cell50 shelf7)
            ;; Position of ketchup
            (adjacent cell32 shelf8)

            ;; Position of robot
            (at_shopbot cell1)

            ;; Positon of items
            (at_item ice_lolly shelf1)
            (at_item pizza shelf2)
            (at_item cabbage shelf3)
            (at_item potato shelf4)
            (at_item toothpaste shelf5)
            (at_item shampoo shelf6)
            (at_item bread shelf7)
            (at_item ketchup shelf8)

            ;; Items needed weigh
            (weighable potato)
            (weighable cabbage)
            (weighable bread)

        )

        (:goal
            (and
                (checkedout potato)
                (checkedout ketchup)
                (checkedout toothpaste)
                (checkedout pizza)
                (checkedout ice_lolly)
                (checkedout cabbage)
                (checkedout shampoo)
                (checkedout bread))
        )
)