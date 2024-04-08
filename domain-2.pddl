(define (domain shopbot_supermarket_with_basket)
    (:requirements :adl :typing :strips)

    (:types
        location
        aisle_cell shelf weighing_scale checkout_stand basketLoc - location
        item
        produce non_produce - item
        Basket
        shopbot
    )

    (:predicates
        (adjacent ?loc1 - location ?loc2 - location)
        (at_shopbot ?loc - aisle_cell)
        (at_item ?item - item ?loc - location)
        (holding ?bot - shopbot ?item - item)
        (weighable ?item - item)
        (weighed ?item - item)
        (checkedout ?item - item)
        (in_basket ?item - item)
        (basket_available ?basketloc - basketLoc)
        (holding_basket ?bot - shopbot ?basket - Basket)
        (holding_nothing ?bot - shopbot)
    )

    (:constants bot - shopbot)

    (:action move
        :parameters (?bot - shopbot ?from - aisle_cell ?to - aisle_cell)
        :precondition (and (at_shopbot ?from) (adjacent ?from ?to))
        :effect (and (at_shopbot ?to) (not (at_shopbot ?from)))
    )

    (:action pick_up
        :parameters (?bot - shopbot ?item - item ?botLoc - aisle_cell ?itemLoc - location)
        :precondition (and
                          (at_shopbot ?botLoc)
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
                          (at_shopbot ?botLoc)
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
                          (at_shopbot ?botLoc) 
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
                          (at_shopbot ?botLoc)
                          (at_item ?item ?checkout)
                          (adjacent ?botLoc ?checkout)
                          (or (not (weighable ?item)) (weighed ?item))
                          (holding_nothing ?bot)
                      )
        :effect (checkedout ?item)
    )

    (:action pick_up_basket
        :parameters (?bot - shopbot ?basket - Basket ?botLoc - aisle_cell ?basketloc - basketLoc)
        :precondition (and
                          (at_shopbot ?botLoc)
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
                          (at_shopbot ?botLoc)
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
                          (at_shopbot ?botLoc)
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
                          (at_shopbot ?botLoc)
                          (adjacent ?botLoc ?checkout)
                          (forall (?otherItem - item) (not (in_basket ?otherItem)))
                      )
        :effect (and 
                    (holding_nothing ?bot)
                    (not (holding_basket ?bot ?basket))
                )
    )
)
