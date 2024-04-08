(define (domain shopbot_supermarket5)
    (:requirements :adl :typing :strips :fluents) 

    (:types
        location
        aisle_cell shelf weighing_scale checkout_stand top_up_station - location
        item
        produce non_produce - item
        shopbot
    )

    (:predicates
        (adjacent ?loc1 - location ?loc2 - location)
        (at_shopbot ?loc - aisle_cell)
        (at_item ?item - item ?loc - shelf)
        (weighable ?item - item)
        (weighed ?item - item)
    )

    (:functions
        (balance)
        (price ?item - item)
        (item_needed ?item - item)
        (item_in_basket  ?item - item)
        (basket_capacity)
    )

    (:action move
        :parameters (?from - aisle_cell ?to - aisle_cell)
        :precondition (and 
                          (at_shopbot ?from) 
                          (adjacent ?from ?to)
                      )
        :effect (and 
                    (at_shopbot ?to) 
                    (not (at_shopbot ?from))
                )
    )

    (:action pick_up_with_enough_capacity
        :parameters (?item - item ?botLoc - aisle_cell ?itemLoc - shelf)
        :precondition (and
                        (at_shopbot ?botLoc)
                        (adjacent ?botLoc ?itemLoc)
                        (at_item ?item ?itemLoc)
                        (>= (basket_capacity) (item_needed ?item))
                    )
        :effect (and
                    (decrease (basket_capacity) (item_needed ?item))
                    (increase (item_in_basket ?item) (item_needed ?item))
                )
    )

    (:action pick_up_without_enough_capacity
        :parameters (?item - item ?botLoc - aisle_cell ?itemLoc - shelf)
        :precondition (and
                        (at_shopbot ?botLoc)
                        (adjacent ?botLoc ?itemLoc)
                        (at_item ?item ?itemLoc)
                        (< (basket_capacity) (item_needed ?item))
                    )
        :effect (and
                    (decrease (basket_capacity) (basket_capacity))
                    (increase (item_in_basket ?item) (basket_capacity))
                )
    )

    (:action weigh_item
        :parameters (?item - produce ?scale - weighing_scale ?botLoc - aisle_cell)
        :precondition (and 
                          (adjacent ?botLoc ?scale) 
                          (at_shopbot?botLoc) 
                          (weighable ?item)
                          (> (item_in_basket ?item) 0)
                      )
        :effect (and
                    (weighed ?item)
                    (not (weighable ?item))
                )
    )

    (:action check_out
        :parameters (?item - item ?checkout - checkout_stand ?botLoc - aisle_cell)
        :precondition (and 
                          (at_shopbot ?botLoc)
                          (> (item_in_basket ?item) 0)
                          (adjacent ?botLoc ?checkout)
                          (or (not (weighable ?item)) (weighed ?item))
                          (>= (balance) (* (item_in_basket ?item) (price ?item)))
                      )
        :effect (and 
                    (decrease (balance) (* (item_in_basket ?item) (price ?item)))
                    (increase (basket_capacity) (item_in_basket ?item))
                    (decrease (item_needed ?item) (item_in_basket ?item))
                    (decrease (item_in_basket ?item) (item_in_basket ?item))
                    (not (weighed ?item))
                    (weighable ?item)
                )
    )

    (:action top_up_credits
        :parameters (?top_up_loc - top_up_station ?botLoc - aisle_cell) 
        :precondition (and
                          (at_shopbot ?botLoc)
                          (adjacent ?botLoc ?top_up_loc) 
                      )
        :effect (increase (balance) 5)
    )
)