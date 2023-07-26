-- Script SQL para criação do esquema do banco de dados para o contexto de uma oficina.

-- -----------------------------------------------------
-- Schema oficina
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `oficina` ;

-- -----------------------------------------------------
-- Schema oficina
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `oficina` DEFAULT CHARACTER SET utf8 ;
USE `oficina` ;

-- -----------------------------------------------------
-- Table `oficina`.`cidades`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oficina`.`cidades` ;

CREATE TABLE IF NOT EXISTS `oficina`.`cidades` (
  `id` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`oficinas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oficina`.`oficinas` ;

CREATE TABLE IF NOT EXISTS `oficina`.`oficinas` (
  `id` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `endereco` VARCHAR(255) NOT NULL,
  `id_cidade` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_odifinas_cidades_idx` (`id_cidade` ASC) VISIBLE,
  CONSTRAINT `fk_odifinas_cidades`
    FOREIGN KEY (`id_cidade`)
    REFERENCES `oficina`.`cidades` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`posicoes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oficina`.`posicoes` ;

CREATE TABLE IF NOT EXISTS `oficina`.`posicoes` (
  `id` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`empregados`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oficina`.`empregados` ;

CREATE TABLE IF NOT EXISTS `oficina`.`empregados` (
  `id` INT NOT NULL,
  `nome_completo` VARCHAR(255) NULL,
  `CPF` CHAR(11) NULL,
  `id_posicao` INT NULL,
  `id_cidade` INT NULL,
  `endereco` VARCHAR(255) NULL,
  `data_contratacao` DATE NULL,
  `data_demissao` DATE NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_empregados_posicoes_idx` (`id_posicao` ASC) VISIBLE,
  INDEX `fk_empregados_cidades_idx` (`id_cidade` ASC) VISIBLE,
  CONSTRAINT `fk_empregados_posicoes`
    FOREIGN KEY (`id_posicao`)
    REFERENCES `oficina`.`posicoes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empregados_cidades`
    FOREIGN KEY (`id_cidade`)
    REFERENCES `oficina`.`cidades` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`escalas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oficina`.`escalas` ;

CREATE TABLE IF NOT EXISTS `oficina`.`escalas` (
  `id` INT NOT NULL,
  `id_oficina` INT NULL,
  `id_empregado` INT NULL,
  `id_posicao` INT NULL,
  `data` DATE NULL,
  `hora_inicio` TIME NULL,
  `hora_fim` TIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_escalas_oficinas_idx` (`id_oficina` ASC) VISIBLE,
  INDEX `fk_escalas_empregados_idx` (`id_empregado` ASC) VISIBLE,
  INDEX `fk_escalas_posicoes_idx` (`id_posicao` ASC) VISIBLE,
  CONSTRAINT `fk_escalas_oficinas`
    FOREIGN KEY (`id_oficina`)
    REFERENCES `oficina`.`oficinas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_escalas_empregados`
    FOREIGN KEY (`id_empregado`)
    REFERENCES `oficina`.`empregados` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_escalas_posicoes`
    FOREIGN KEY (`id_posicao`)
    REFERENCES `oficina`.`posicoes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`tipos_contato`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oficina`.`tipos_contato` ;

CREATE TABLE IF NOT EXISTS `oficina`.`tipos_contato` (
  `id` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`clientes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oficina`.`clientes` ;

CREATE TABLE IF NOT EXISTS `oficina`.`clientes` (
  `id` INT NOT NULL,
  `nome_pessoa` VARCHAR(255) NULL,
  `nome_empresa` VARCHAR(255) NULL,
  `CPF` CHAR(11) NULL,
  `CNPJ` CHAR(14) NULL,
  `id_cidade` INT NULL,
  `endereco` VARCHAR(255) NULL,
  `celular` VARCHAR(20) NULL,
  `email` VARCHAR(128) NULL,
  `detalhes` TEXT NULL,
  `data_cadastro` DATE NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_clientes_cidades_idx` (`id_cidade` ASC) VISIBLE,
  CONSTRAINT `fk_clientes_cidades`
    FOREIGN KEY (`id_cidade`)
    REFERENCES `oficina`.`cidades` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`contatos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oficina`.`contatos` ;

CREATE TABLE IF NOT EXISTS `oficina`.`contatos` (
  `id` INT NOT NULL,
  `id_tipo_contato` INT NULL,
  `id_cliente` INT NULL,
  `id_escala` INT NULL,
  `detalhes` TEXT NULL,
  `hora_do_contato` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_contatos_escalas_idx` (`id_escala` ASC) VISIBLE,
  INDEX `fk_contatos_tiposcontato_idx` (`id_tipo_contato` ASC) VISIBLE,
  INDEX `fk_contatos_clientes_idx` (`id_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_contatos_escalas`
    FOREIGN KEY (`id_escala`)
    REFERENCES `oficina`.`escalas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contatos_tiposcontato`
    FOREIGN KEY (`id_tipo_contato`)
    REFERENCES `oficina`.`tipos_contato` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contatos_clientes`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `oficina`.`clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`fabricantes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oficina`.`fabricantes` ;

CREATE TABLE IF NOT EXISTS `oficina`.`fabricantes` (
  `id` INT NOT NULL,
  `nome` VARCHAR(90) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`tipos_veiculo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oficina`.`tipos_veiculo` ;

CREATE TABLE IF NOT EXISTS `oficina`.`tipos_veiculo` (
  `id` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`modelos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oficina`.`modelos` ;

CREATE TABLE IF NOT EXISTS `oficina`.`modelos` (
  `id` INT NOT NULL,
  `nome` VARCHAR(90) NULL,
  `id_fabricante` INT NULL,
  `id_tipo` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_modelos_fabricantes_idx` (`id_fabricante` ASC) VISIBLE,
  INDEX `fk_modelos_tipos_idx` (`id_tipo` ASC) VISIBLE,
  CONSTRAINT `fk_modelos_fabricantes`
    FOREIGN KEY (`id_fabricante`)
    REFERENCES `oficina`.`fabricantes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_modelos_tipos`
    FOREIGN KEY (`id_tipo`)
    REFERENCES `oficina`.`tipos_veiculo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`veiculos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oficina`.`veiculos` ;

CREATE TABLE IF NOT EXISTS `oficina`.`veiculos` (
  `id` INT NOT NULL,
  `placa` VARCHAR(45) NULL,
  `numero_chassi` VARCHAR(45) NULL,
  `id_cliente` INT NULL,
  `id_modelo` INT NULL,
  `data_fabricacao` DATE NULL,
  `detalhes` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_veiculos_clientes_idx` (`id_cliente` ASC) VISIBLE,
  INDEX `fk_veiculos_modelos_idx` (`id_modelo` ASC) VISIBLE,
  CONSTRAINT `fk_veiculos_clientes`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `oficina`.`clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_veiculos_modelos`
    FOREIGN KEY (`id_modelo`)
    REFERENCES `oficina`.`modelos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`catalogo_tarefas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oficina`.`catalogo_tarefas` ;

CREATE TABLE IF NOT EXISTS `oficina`.`catalogo_tarefas` (
  `id` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  `descricao` TEXT NULL,
  `tempo_minutos` INT NULL,
  `preco` DECIMAL(10,2) NULL,
  `ativo` TINYINT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`catalogo_servicos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oficina`.`catalogo_servicos` ;

CREATE TABLE IF NOT EXISTS `oficina`.`catalogo_servicos` (
  `id` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  `descricao` TEXT NULL,
  `ativo` TINYINT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`servicos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oficina`.`servicos` ;

CREATE TABLE IF NOT EXISTS `oficina`.`servicos` (
  `id` INT NOT NULL,
  `id_cliente` INT NULL,
  `id_veiculo` INT NULL,
  `id_catalogo_servico` INT NULL,
  `preco` DECIMAL(10,2) NULL,
  `desconto` DECIMAL(10,2) NULL,
  `hora_criacao` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_servicos_clientes_idx` (`id_cliente` ASC) VISIBLE,
  INDEX `fk_servicos_veiculos_idx` (`id_veiculo` ASC) VISIBLE,
  INDEX `fk_servicos_catalogo_idx` (`id_catalogo_servico` ASC) VISIBLE,
  CONSTRAINT `fk_servicos_clientes`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `oficina`.`clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_servicos_veiculos`
    FOREIGN KEY (`id_veiculo`)
    REFERENCES `oficina`.`veiculos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_servicos_catalogo`
    FOREIGN KEY (`id_catalogo_servico`)
    REFERENCES `oficina`.`catalogo_servicos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`tarefas_por_servico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oficina`.`tarefas_por_servico` ;

CREATE TABLE IF NOT EXISTS `oficina`.`tarefas_por_servico` (
  `id_servico` INT NOT NULL,
  `id_catalogo_tarefa` INT NOT NULL,
  `preco` DECIMAL(10,2) NULL,
  INDEX `fk_tarefas_servicos_idx` (`id_servico` ASC) VISIBLE,
  INDEX `fk_tarefas_catalogo_idx` (`id_catalogo_tarefa` ASC) VISIBLE,
  PRIMARY KEY (`id_servico`, `id_catalogo_tarefa`),
  CONSTRAINT `fk_tarefas_servicos`
    FOREIGN KEY (`id_servico`)
    REFERENCES `oficina`.`servicos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tarefas_catalogo`
    FOREIGN KEY (`id_catalogo_tarefa`)
    REFERENCES `oficina`.`catalogo_tarefas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`catalogos_servicos_tarefas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oficina`.`catalogos_servicos_tarefas` ;

CREATE TABLE IF NOT EXISTS `oficina`.`catalogos_servicos_tarefas` (
  `id_catalogo_servicos` INT NOT NULL,
  `id_catalogo_tarefas` INT NOT NULL,
  PRIMARY KEY (`id_catalogo_servicos`, `id_catalogo_tarefas`),
  INDEX `fk_catalogos_tarefa_idx` (`id_catalogo_tarefas` ASC) VISIBLE,
  CONSTRAINT `fk_catalogos_servico`
    FOREIGN KEY (`id_catalogo_servicos`)
    REFERENCES `oficina`.`catalogo_servicos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_catalogos_tarefa`
    FOREIGN KEY (`id_catalogo_tarefas`)
    REFERENCES `oficina`.`catalogo_tarefas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW TABLES;