package com.hczhang.usales.prodm

class Product {

    String name
    String description
    String picPath
    Float listPrice = 0

    Category category

    static constraints = {
        name nullable: false, size: 2..30
        picPath nullable: true
        description nullable: true
    }

    String getDisplayString() {
        return name
    }

    @Override
    public String toString() {
        return """\
Product{
    name='$name',
    description='$description',
    picPath='$picPath',
    listPrice=$listPrice,
    category=$category
}"""
    }
}
