const mongoose = require('mongoose')
const Schema = mongoose.Schema


const Area = Schema({
    nome: {
        type: String,
        required: true
    },
    slug:{
        type: String,
        required: true
    },
    data:{
        type: Date,
        default: Date.now
    }
})

mongoose.model('area',Area)