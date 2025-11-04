class CreateVagaRondoniaAoVivos < ActiveRecord::Migration[8.0]
  def change
    create_table :vaga_rondonia_ao_vivos do |t|
      t.string :url, null: false
      t.string :identificador
      t.string :empresa
      t.string :email
      t.string :endereco
      t.string :bairro
      t.string :cidade
      t.string :estado
      t.string :contato
      t.string :funcao
      t.text :detalhes
      t.string :nivel_escolaridade
      t.string :informacoes_salario
      t.string :horario_trabalho
      t.text :informacoes_adicionais
      t.date :data_cadastro

      t.timestamps
    end

    add_index :vaga_rondonia_ao_vivos, :url, unique: true
  end
end
