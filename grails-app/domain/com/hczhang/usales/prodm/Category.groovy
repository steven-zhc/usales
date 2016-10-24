package com.hczhang.usales.prodm

class Category {

    String name
    String desription

    static belongsTo = [parent : Category]

    static constraints = {
        name nullable: false
        parent nullable: true
        desription nullable: true
    }

    @Override
    String toString() {
        return name
    }
}
