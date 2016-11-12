package com.hczhang.usales.prodm

class Category {

    String name
    String description

    static belongsTo = [parent : Category]

    static constraints = {
        name nullable: false, size: 2..30
        parent nullable: true
        description nullable: true
    }

    String getDisplayString() {
        return name
    }
}
