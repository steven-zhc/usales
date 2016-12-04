package com.hczhang.usales.prodm

class Product {

    String name
    String description
    String picPath
    Float listPrice = 0
    String url

    Category category

    static constraints = {
        name nullable: false, size: 2..150
        description size: 2..255
        url size: 1..255
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
    url='$url', 
    category=$category
}"""
    }


}

