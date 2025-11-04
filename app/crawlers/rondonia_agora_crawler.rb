# RondoniaAgoraCrawler.new.call

class RondoniaAgoraCrawler
  def initialize
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument("--headless=new")
    options.add_argument("--disable-gpu")
    options.add_argument("--blink-settings=imagesEnabled=false")

    @driver = Selenium::WebDriver.for(:chrome, options: options)
    @driver.manage.timeouts.page_load = 60

    @base_url = "https://empregos.rondoniaovivo.com/vagas"
  end

  def call
    vagas_url = []

    numero_pagina = 1

    parar = false

    loop do
      @driver.get(@base_url + "/?pagina=#{numero_pagina}")

      vagas_cartoes = @driver.find_elements(css: "ul li .content-area")

      vagas_cartoes.each do |vc|
        vaga_data_publicacao = vc.find_element(css: ".ad-details ul li:nth-child(1)").text.to_date

        if vaga_data_publicacao < (Date.today - 1.day)
          parar = true

          break
        end

        vagas_url << vc.find_element(tag_name: "a").attribute("href")
      end

      break if parar

      numero_pagina += 1
    end

    vagas_data = []

    vagas_url.each do |url|
      @driver.get url

      infos = @driver.find_elements(css: "dl dd")

      dados = {
        url: url,
        empresa: infos[0]&.text.to_s.strip,
        email: infos[1]&.text.to_s.strip,
        endereco: infos[2]&.text.to_s.strip,
        bairro: infos[3]&.text.to_s.strip,
        cidade: infos[4]&.text.to_s.strip,
        estado: infos[5]&.text.to_s.strip,
        contato: infos[6]&.text.to_s.strip,
        funcao: infos[7]&.text.to_s.strip,
        detalhes: infos[8]&.text.to_s.strip,
        nivel_escolaridade: infos[9]&.text.to_s.strip,
        informacoes_salario: infos[10]&.text.to_s.strip,
        horario_trabalho: infos[11]&.text.to_s.strip,
        informacoes_adicionais: infos[12]&.text.to_s.strip,
        data_cadastro: (infos[13]&.text.to_s[/\d{2}\/\d{2}\/\d{4}/]&.to_date rescue nil)
      }

      vagas_data << dados
    end

    VagaRondoniaAoVivo.insert_all(vagas_data, unique_by: :url) if vagas_data.any?

    @driver.quit
  rescue => erro
    LogErroRaspagem.create(erro: erro.to_s)

    @driver.quit if @driver
  end
end