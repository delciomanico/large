const mongoose = require('mongoose')
const Schema = mongoose.Schema


const Curso = Schema({
    nome: {
        type: String,
        required: true
    },
    slug:{
        type: String,
        required: true
    },
    area_f:{
        type: Schema.Types.ObjectId,
        ref: "area",
        required: true
    },
    data:{
        type: Date,
        default: Date.now
    }
})

mongoose.model('curso',Curso)