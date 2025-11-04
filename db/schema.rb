# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_11_04_015554) do
  create_table "log_erro_raspagems", force: :cascade do |t|
    t.string "erro"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vaga_rondonia_ao_vivos", force: :cascade do |t|
    t.string "url", null: false
    t.string "identificador"
    t.string "empresa"
    t.string "email"
    t.string "endereco"
    t.string "bairro"
    t.string "cidade"
    t.string "estado"
    t.string "contato"
    t.string "funcao"
    t.text "detalhes"
    t.string "nivel_escolaridade"
    t.string "informacoes_salario"
    t.string "horario_trabalho"
    t.text "informacoes_adicionais"
    t.date "data_cadastro"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["url"], name: "index_vaga_rondonia_ao_vivos_on_url", unique: true
  end
end
