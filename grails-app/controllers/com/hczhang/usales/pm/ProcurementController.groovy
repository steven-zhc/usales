package com.hczhang.usales.pm

class ProcurementController {

    static scaffold = Procurement

    def index() { }

    def search() {}

    def searchResult(String pname) {
        def ps = Procurement.where {
            product.name =~ "%${pname}%"
        }.list()

        return [procurements: ps]
    }

}
