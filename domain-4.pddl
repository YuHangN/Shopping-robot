(define (domain shopbot_supermarket4)
    (:requirements :adl :fluents)

    (:types
        location
        aisle_cell shelf weighing_scale checkout_stand basketLoc top_up_station - location
        item
        produce non_produce - item
        Basket
        shopbot
    )

    (:predicates
        (adjacent ?loc1 - location ?loc2 - location)
        (at_shopbot ?bot - shopbot ?loc - aisle_cell)
        (at_item ?item - item ?loc - location)
        (holding ?bot - shopbot ?item - item)
        (weighable ?item - item)
        (weighed ?item - item)
        (checkedout ?item - item)
        (in_basket ?item - item)
        (basket_available ?basketloc - basketLoc)
        (holding_basket ?bot - shopbot ?basket - Basket)
        (holding_nothing ?bot - shopbot)
        (checked_out_by ?bot - shopbot ?item - item)
        (occupied ?loc - aisle_cell)
    )


    (:functions
        (balance ?bot - shopbot)
        (price ?item - item)
    )

    (:action move
        :parameters (?bot - shopbot ?from - aisle_cell ?to - aisle_cell)
        :precondition (and 
                          (at_shopbot ?bot ?from)
                          (adjacent ?from ?to)
                          (not (occupied ?to))
                      )
        :effect (and 
                    (at_shopbot ?bot ?to) 
                    (not (at_shopbot ?bot ?from))
                    (occupied ?to)
                    (not (occupied ?from))
                )
    )

    (:action pick_up
        :parameters (?bot - shopbot ?item - item ?botLoc - aisle_cell ?itemLoc - location)
        :precondition (and
                          (at_shopbot ?bot ?botLoc)
                          (adjacent ?botLoc ?itemLoc)
                          (at_item ?item ?itemLoc)
                          (holding_nothing ?bot)
                      )
        :effect (and
                    (holding ?bot ?item)
                    (not (at_item ?item ?itemLoc))
                    (not (holding_nothing ?bot))
                )
    )

    (:action drop
        :parameters (?bot - shopbot ?item - item ?dropLoc - location ?botLoc - aisle_cell)
        :precondition (and 
                          (holding ?bot ?item)
                          (at_shopbot ?bot ?botLoc)
                          (adjacent ?botLoc ?dropLoc)
                      )
        :effect (and 
                    (at_item ?item ?dropLoc)
                    (holding_nothing ?bot)
                    (not (holding ?bot ?item))
                )
    )

    (:action weigh_item
        :parameters (?bot - shopbot ?item - produce ?scale - weighing_scale ?botLoc - aisle_cell)
        :precondition (and 
                          (or (in_basket ?item) (holding ?bot ?item)) 
                          (adjacent ?botLoc ?scale) 
                          (at_shopbot ?bot ?botLoc) 
                          (weighable ?item)
                      )
        :effect (and
                    (weighed ?item)
                    (not (weighable ?item))
                )
    )

    (:action check_out
        :parameters (?bot - shopbot ?item - item ?checkout - checkout_stand ?botLoc - aisle_cell)
        :precondition (and 
                          (at_shopbot ?bot ?botLoc)
                          (at_item ?item ?checkout)
                          (adjacent ?botLoc ?checkout)
                          (holding_nothing ?bot)
                          (or (not (weighable ?item)) (weighed ?item))
                          (>= (balance ?bot) (price ?item))
                      )
        :effect (and 
                    (checkedout ?item)
                    (decrease (balance ?bot) (price ?item))
                    (checked_out_by ?bot ?item)
                )
    )

    (:action pick_up_basket
        :parameters (?bot - shopbot ?basket - Basket ?botLoc - aisle_cell ?basketloc - basketLoc)
        :precondition (and
                          (at_shopbot ?bot ?botLoc)
                          (adjacent ?botLoc ?basketloc)
                          (basket_available ?basketloc)
                          (holding_nothing ?bot)
                      )
        :effect (and 
                    (holding_basket ?bot ?basket)
                    (not (holding_nothing ?bot))
                )    

    )

    (:action put_in_basket
        :parameters (?bot - shopbot ?basket - Basket ?botLoc - aisle_cell ?item - item ?itemLoc - shelf)
        :precondition (and
                          (at_shopbot ?bot ?botLoc)
                          (at_item ?item ?itemLoc)
                          (adjacent ?botLoc ?itemLoc)
                          (holding_basket ?bot ?basket)
                      )
        :effect (in_basket ?item)
    )

    (:action take_out_basket
        :parameters (?bot - shopbot ?basket - Basket ?botLoc - aisle_cell ?item - item ?takeoutLoc - checkout_stand)
        :precondition (and
                          (holding_basket ?bot ?basket)
                          (at_shopbot ?bot ?botLoc)
                          (adjacent ?botLoc ?takeoutLoc)
                          (in_basket ?item) 
                      ) 
        :effect (and
                    (not (in_basket ?item))
                    (at_item ?item ?takeoutLoc)
                )
    )

    (:action return_basket
        :parameters (?bot - shopbot ?basket - Basket ?botLoc - aisle_cell ?checkout - checkout_stand)
        :precondition (and
                          (holding_basket ?bot ?basket)
                          (at_shopbot ?bot ?botLoc)
                          (adjacent ?botLoc ?checkout)
                      )
        :effect (and 
                    (holding_nothing ?bot)
                    (not (holding_basket ?bot ?basket))
                )
    )

    (:action top_up_credits
        :parameters (?bot - shopbot ?top_up_loc - top_up_station ?botLoc - aisle_cell) 
        :precondition (and
                          (at_shopbot ?bot ?botLoc)
                          (adjacent ?botLoc ?top_up_loc)
                      )
        :effect (increase (balance ?bot) 5)
    )
)