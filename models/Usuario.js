const mongoose = require('mongoose')
const Schema = mongoose.Schema

const Usuario = Schema({
    nome: {
        type: String,
        required: false
    },
    senha:{
        type: String,
        required: true
    },
    eAdmin:{
        type: Number,
        require: false
    },
    email:{
        type: String,
        required: false
    },
    data:{
        type: Date,
        default: Date.now
    }
})

mongoose.model('usuario',Usuario)