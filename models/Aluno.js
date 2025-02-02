const mongoose = require('mongoose')
const Schema = mongoose.Schema


const Aluno = Schema({
    nome: {
        type: String,
        required: true
    },
    bi:{
        type: String,
        required: true
    },
    tel:{
        type: String,
        required: false
    },
    media:{
        type: Number,
        required: true
    },
    trabalho:{
        type: String,
        required: false
    },
    faculdade:{
        type: String,
        required: false
    },
    mestrado:{
        type: String,
        required: false
    },
    curso:{
        type: Schema.Types.ObjectId,
        ref: "curso",
        required: true
    },
    start:{
        type:  Date,
        required: true
    },
    end:{
        type:  Date,
        required: true
    },
    created_data:{
        type: Date,
        default: Date.now
    }
})

mongoose.model('aluno',Aluno)