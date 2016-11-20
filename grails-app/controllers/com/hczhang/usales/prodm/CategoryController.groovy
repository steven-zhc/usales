package com.hczhang.usales.prodm

class CategoryController {

    static defaultAction = "list"

    def add() {
        ["categories": Category.list()]
    }

    def save() {
        def cat = new Category(params)

        if (cat.save()) {
            flash.message = "Added a new Category."
            redirect action: "show", id: cat.id
        } else {
            render view: "add", model: ["category": cat]
        }
    }

    def show() {
        def cat = Category.findById(params.id)

        if (cat) {
            ["category": cat]
        } else {
            ["message": "Not Found."]
        }
    }

    def list(String name) {

        if (!name) {
            ["categories": Category.list()]
        } else {
            def list = Category.where {
                name =~ "%${name}%"
            }.list()
            ["name": name, "categories": list]
        }
    }
}

class SearchCategoryCommand {
    String name

    static constraints = {
        importFrom Category
    }
}
