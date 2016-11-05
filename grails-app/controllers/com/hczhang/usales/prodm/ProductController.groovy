package com.hczhang.usales.prodm

class ProductController {

    static scaffold = Product

    def index() { }

    def search(SearchProductCommand cmd) {
        if (cmd.hasErrors()) {
            ["products": Product.list()]
        } else {
            def list = Product.where {
                name =~ "%${cmd.name}%"
                if (cmd?.cid) {
                    category.id = cmd.cid
                }
            }.list()
            ["command": cmd, "products": list]
        }

    }

    def add() {
        ["categories": Category.list()]
    }

    def save(SaveProductCommand cmd) {
      if (cmd.hasErrors()) {
        flash.message = "Error add Product"
      } else {
        def p = new Product(cmd.properties)
        def c = Category.where {
          id = cmd.cid
        }.list()
        p.category = c

        if (p.validate() && p.save()) {
          flash.message = "successful"
        } else {
          ["product": cmd]
        }
      }
    }
}

class SearchProductCommand {
    String name
    Integer cid

    static constraints = {
        importFrom Product
    }
}

class SaveProductCommand {
    String name
    String description
    String picPath
    Float listPrice
    Ineger cid

    static constraints = {
        importFrom Product
    }

}
