class CreateLogErroRaspagems < ActiveRecord::Migration[8.0]
  def change
    create_table :log_erro_raspagems do |t|
      t.string :erro

      t.timestamps
    end
  end
end
