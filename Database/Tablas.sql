-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;


-- -----------------------------------------------------
-- Table `mydb`.`Organismo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Organismo` (
  `idOrganismo` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idOrganismo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Parque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Parque` (
  `idParque` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `FechaInauguracion` DATE NOT NULL,
  INDEX `idParque_idx` (`idParque` ASC) VISIBLE,
  PRIMARY KEY (`idParque`));


-- -----------------------------------------------------
-- Table `mydb`.`ParqueXComunidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ParqueXComunidad` (
  `Comunidad_idComunidad` INT NOT NULL,
  `Parque_idParque` INT NOT NULL,
  INDEX `fk_ParqueXComunidad_Comunidad_idx` (`Comunidad_idComunidad` ASC) VISIBLE,
  INDEX `fk_ParqueXComunidad_Parque1_idx` (`Parque_idParque` ASC) VISIBLE,
  CONSTRAINT `fk_ParqueXComunidad_Comunidad`
    FOREIGN KEY (`Comunidad_idComunidad`)
    REFERENCES `mydb`.`Comunidad` (`idComunidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ParqueXComunidad_Parque1`
    FOREIGN KEY (`Parque_idParque`)
    REFERENCES `mydb`.`Parque` (`idParque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`AreaParque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AreaParque` (
  `idAreaParque` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Extension` DECIMAL(10,2) NOT NULL,
  `Parque_idParque` INT NOT NULL,
  PRIMARY KEY (`idAreaParque`),
  INDEX `fk_AreaParque_Parque1_idx` (`Parque_idParque` ASC) VISIBLE,
  INDEX `Extension_idx` (`Extension` ASC) VISIBLE,
  CONSTRAINT `fk_AreaParque_Parque1`
    FOREIGN KEY (`Parque_idParque`)
    REFERENCES `mydb`.`Parque` (`idParque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`Especie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Especie` (
  `idEspecie` INT NOT NULL AUTO_INCREMENT,
  `NombreCientifico` VARCHAR(45) NOT NULL,
  `NombreVulgar` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEspecie`));


-- -----------------------------------------------------
-- Table `mydb`.`Planta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Planta` (
  `Especie_idEspecie` INT NOT NULL,
  `InicioFloracion` DATE NULL,
  `FinFloracion` DATE NULL,
  CONSTRAINT `fk_Planta_Especie1`
    FOREIGN KEY (`Especie_idEspecie`)
    REFERENCES `mydb`.`Especie` (`idEspecie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`Mineral`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Mineral` (
  `Especie_idEspecie` INT NOT NULL,
  `Cristal` INT NOT NULL,
  CONSTRAINT `fk_Mineral_Especie1`
    FOREIGN KEY (`Especie_idEspecie`)
    REFERENCES `mydb`.`Especie` (`idEspecie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`Alimentacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Alimentacion` (
  `idAlimentacion` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idAlimentacion`));


-- -----------------------------------------------------
-- Table `mydb`.`Animal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Animal` (
  `Especie_idEspecie` INT NOT NULL,
  `Alimentacion_idAlimentacion` INT NOT NULL,
  `InicioCelo` DATE NOT NULL,
  `FinCelo` DATE NOT NULL,
  CONSTRAINT `fk_Animal_Alimentacion1`
    FOREIGN KEY (`Alimentacion_idAlimentacion`)
    REFERENCES `mydb`.`Alimentacion` (`idAlimentacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Animal_Especie1`
    FOREIGN KEY (`Especie_idEspecie`)
    REFERENCES `mydb`.`Especie` (`idEspecie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`CadenaAlimenticia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CadenaAlimenticia` (
  `Cazador` INT NOT NULL,
  `Presa` INT NOT NULL,
  CONSTRAINT `fk_CadenaAlimenticia_Especie1`
    FOREIGN KEY (`Cazador`)
    REFERENCES `mydb`.`Especie` (`idEspecie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CadenaAlimenticia_Especie2`
    FOREIGN KEY (`Presa`)
    REFERENCES `mydb`.`Especie` (`idEspecie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`EspecieXArea`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`EspecieXArea` (
  `Cantidad` INT NOT NULL,
  `Especie_idEspecie` INT NOT NULL,
  `AreaParque_idAreaParque` INT NOT NULL,
  CONSTRAINT `fk_EspecieXArea_Especie1`
    FOREIGN KEY (`Especie_idEspecie`)
    REFERENCES `mydb`.`Especie` (`idEspecie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EspecieXArea_AreaParque1`
    FOREIGN KEY (`AreaParque_idAreaParque`)
    REFERENCES `mydb`.`AreaParque` (`idAreaParque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`Pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pais` (
  `idPais` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPais`));


-- -----------------------------------------------------
-- Table `mydb`.`Provincia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Provincia` (
  `idProvincia` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Pais_idPais` INT NOT NULL,
  PRIMARY KEY (`idProvincia`),
  CONSTRAINT `fk_Provincia_Pais1`
    FOREIGN KEY (`Pais_idPais`)
    REFERENCES `mydb`.`Pais` (`idPais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`Canton`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Canton` (
  `idCanton` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Provincia_idProvincia` INT NOT NULL,
  PRIMARY KEY (`idCanton`),
  CONSTRAINT `fk_Canton_Provincia1`
    FOREIGN KEY (`Provincia_idProvincia`)
    REFERENCES `mydb`.`Provincia` (`idProvincia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`Distrito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Distrito` (
  `idDistrito` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Canton_idCanton` INT NOT NULL,
  PRIMARY KEY (`idDistrito`),
  CONSTRAINT `fk_Distrito_Canton1`
    FOREIGN KEY (`Canton_idCanton`)
    REFERENCES `mydb`.`Canton` (`idCanton`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`Ubicacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Ubicacion` (
  `idUbicacion` INT NOT NULL AUTO_INCREMENT,
  `Descripcion` VARCHAR(45) NOT NULL,
  `Distrito_idDistrito` INT NOT NULL,
  PRIMARY KEY (`idUbicacion`),
  CONSTRAINT `fk_Ubicacion_Distrito1`
    FOREIGN KEY (`Distrito_idDistrito`)
    REFERENCES `mydb`.`Distrito` (`idDistrito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`Persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Persona` (
  `idPersona` INT NOT NULL AUTO_INCREMENT,
  `Cedula` VARCHAR(45) NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `Apellido` VARCHAR(45) NOT NULL,
  `Telefono` INT NULL,
  `Celular` INT NULL,
  `Email` VARCHAR(45) NULL,
  `Ubicacion_idUbicacion` INT NOT NULL,
  PRIMARY KEY (`idPersona`),
  CONSTRAINT `fk_Persona_Ubicacion1`
    FOREIGN KEY (`Ubicacion_idUbicacion`)
    REFERENCES `mydb`.`Ubicacion` (`idUbicacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`Puesto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Puesto` (
  `idPuesto` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPuesto`));


-- -----------------------------------------------------
-- Table `mydb`.`Empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Empleado` (
  `idEmpleado` INT NOT NULL AUTO_INCREMENT,
  `Puesto_idPuesto` INT NOT NULL,
  `Persona_idPersona` INT NOT NULL,
  `Salario` INT NOT NULL,
  `Parque_idParque` INT NOT NULL,
  PRIMARY KEY (`idEmpleado`),
  CONSTRAINT `fk_Empleado_Puesto1`
    FOREIGN KEY (`Puesto_idPuesto`)
    REFERENCES `mydb`.`Puesto` (`idPuesto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empleado_Persona1`
    FOREIGN KEY (`Persona_idPersona`)
    REFERENCES `mydb`.`Persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empleado_Parque1`
    FOREIGN KEY (`Parque_idParque`)
    REFERENCES `mydb`.`Parque` (`idParque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`Entrada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Entrada` (
  `idEntrada` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Parque_idParque` INT NOT NULL,
  PRIMARY KEY (`idEntrada`),
  CONSTRAINT `fk_Entrada_Parque1`
    FOREIGN KEY (`Parque_idParque`)
    REFERENCES `mydb`.`Parque` (`idParque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`PersonalGestion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PersonalGestion` (
  `Empleado_idEmpleado` INT NOT NULL,
  `Entrada_idEntrada` INT NOT NULL,
  CONSTRAINT `fk_PersonalGestion_Empleado1`
    FOREIGN KEY (`Empleado_idEmpleado`)
    REFERENCES `mydb`.`Empleado` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PersonalGestion_Entrada1`
    FOREIGN KEY (`Entrada_idEntrada`)
    REFERENCES `mydb`.`Entrada` (`idEntrada`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`TipoVehiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TipoVehiculo` (
  `idTipoVehiculo` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`idTipoVehiculo`));


-- -----------------------------------------------------
-- Table `mydb`.`Vehiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Vehiculo` (
  `idVehiculo` INT NOT NULL AUTO_INCREMENT,
  `TipoVehiculo_idTipoVehiculo` INT NOT NULL,
  `Matricula` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idVehiculo`),
  CONSTRAINT `fk_Vehiculo_TipoVehiculo1`
    FOREIGN KEY (`TipoVehiculo_idTipoVehiculo`)
    REFERENCES `mydb`.`TipoVehiculo` (`idTipoVehiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`PersonalVigilante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PersonalVigilante` (
  `Empleado_idEmpleado` INT NOT NULL,
  `Carro_idCarro` INT NOT NULL,
  `AreaParque_idAreaParque` INT NOT NULL,
  CONSTRAINT `fk_PersonalVigilante_Empleado1`
    FOREIGN KEY (`Empleado_idEmpleado`)
    REFERENCES `mydb`.`Empleado` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PersonalVigilante_Carro1`
    FOREIGN KEY (`Carro_idCarro`)
    REFERENCES `mydb`.`Vehiculo` (`idVehiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PersonalVigilante_AreaParque1`
    FOREIGN KEY (`AreaParque_idAreaParque`)
    REFERENCES `mydb`.`AreaParque` (`idAreaParque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`ProyectoInvestigacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ProyectoInvestigacion` (
  `idProyectoInvestigacion` INT NOT NULL AUTO_INCREMENT,
  `Presupuesto` INT NOT NULL,
  `InicioPeriodo` DATE NULL,
  `FinPeriodo` DATE NULL,
  `Especie_idEspecie` INT NOT NULL,
  PRIMARY KEY (`idProyectoInvestigacion`),
  CONSTRAINT `fk_ProyectoInvestigacion_Especie1`
    FOREIGN KEY (`Especie_idEspecie`)
    REFERENCES `mydb`.`Especie` (`idEspecie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`PersonalInvestigador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PersonalInvestigador` (
  `Empleado_idEmpleado` INT NOT NULL,
  `Titulo` VARCHAR(45) NOT NULL,
  `ProyectoInvestigacion_idProyectoInvestigacion` INT NOT NULL,
  CONSTRAINT `fk_PersonalInvestigador_Empleado1`
    FOREIGN KEY (`Empleado_idEmpleado`)
    REFERENCES `mydb`.`Empleado` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PersonalInvestigador_ProyectoInvestigacion1`
    FOREIGN KEY (`ProyectoInvestigacion_idProyectoInvestigacion`)
    REFERENCES `mydb`.`ProyectoInvestigacion` (`idProyectoInvestigacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`Especialidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Especialidad` (
  `idEspecialidad` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEspecialidad`));


-- -----------------------------------------------------
-- Table `mydb`.`PersonalConservacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PersonalConservacion` (
  `Empleado_idEmpleado` INT NOT NULL,
  `AreaParque_idAreaParque` INT NOT NULL,
  `Especialidad_idEspecialidad` INT NOT NULL,
  CONSTRAINT `fk_PersonalConservacion_Empleado1`
    FOREIGN KEY (`Empleado_idEmpleado`)
    REFERENCES `mydb`.`Empleado` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PersonalConservacion_AreaParque1`
    FOREIGN KEY (`AreaParque_idAreaParque`)
    REFERENCES `mydb`.`AreaParque` (`idAreaParque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PersonalConservacion_Especialidad1`
    FOREIGN KEY (`Especialidad_idEspecialidad`)
    REFERENCES `mydb`.`Especialidad` (`idEspecialidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Categoria` (
  `idCategoria` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCategoria`));


-- -----------------------------------------------------
-- Table `mydb`.`Alojamiento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Alojamiento` (
  `idAlojamiento` INT NOT NULL AUTO_INCREMENT,
  `Capacidad` INT NOT NULL,
  `Parque_idParque` INT NOT NULL,
  `Categoria_idCategoria` INT NOT NULL,
  `Ubicacion_idUbicacion` INT NOT NULL,
  PRIMARY KEY (`idAlojamiento`),
  CONSTRAINT `fk_Hospedaje_Parque1`
    FOREIGN KEY (`Parque_idParque`)
    REFERENCES `mydb`.`Parque` (`idParque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Hospedaje_Categoria1`
    FOREIGN KEY (`Categoria_idCategoria`)
    REFERENCES `mydb`.`Categoria` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Alojamiento_Ubicacion1`
    FOREIGN KEY (`Ubicacion_idUbicacion`)
    REFERENCES `mydb`.`Ubicacion` (`idUbicacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`Visitante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Visitante` (
  `idVisitante` INT NOT NULL AUTO_INCREMENT,
  `Persona_idPersona` INT NOT NULL,
  `Hospedaje_idHospedaje` INT NOT NULL,
  PRIMARY KEY (`idVisitante`),
  CONSTRAINT `fk_Visitante_Persona1`
    FOREIGN KEY (`Persona_idPersona`)
    REFERENCES `mydb`.`Persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Visitante_Hospedaje1`
    FOREIGN KEY (`Hospedaje_idHospedaje`)
    REFERENCES `mydb`.`Alojamiento` (`idAlojamiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`Excursion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Excursion` (
  `idExcursion` INT NOT NULL AUTO_INCREMENT,
  `Alojamiento_idAlojamiento` INT NOT NULL,
  `Excursioncol` VARCHAR(45) NULL,
  PRIMARY KEY (`idExcursion`),
  CONSTRAINT `fk_Excursion_Alojamiento1`
    FOREIGN KEY (`Alojamiento_idAlojamiento`)
    REFERENCES `mydb`.`Alojamiento` (`idAlojamiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`HorariosExcursion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`HorariosExcursion` (
  `idHorariosExcursion` INT NOT NULL AUTO_INCREMENT,
  `Dia` VARCHAR(45) NOT NULL,
  `InicioExcursion` TIME NOT NULL,
  `FinExcursion` TIME NOT NULL,
  PRIMARY KEY (`idHorariosExcursion`));


-- -----------------------------------------------------
-- Table `mydb`.`HorarioXExcursion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`HorarioXExcursion` (
  `idHorarioXExcursion` INT NOT NULL AUTO_INCREMENT,
  `HorariosExcursion_idHorariosExcursion` INT NOT NULL,
  `Excursion_idExcursion` INT NOT NULL,
  PRIMARY KEY (`idHorarioXExcursion`),
  CONSTRAINT `fk_HorarioXExcursion_HorariosExcursion1`
    FOREIGN KEY (`HorariosExcursion_idHorariosExcursion`)
    REFERENCES `mydb`.`HorariosExcursion` (`idHorariosExcursion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_HorarioXExcursion_Excursion1`
    FOREIGN KEY (`Excursion_idExcursion`)
    REFERENCES `mydb`.`Excursion` (`idExcursion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`EventoExcursion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`EventoExcursion` (
  `idEventoExcursion` INT NOT NULL AUTO_INCREMENT,
  `HorarioXExcursion_idHorarioXExcursion` INT NOT NULL,
  `TipoVehiculo_idTipoVehiculo` INT NOT NULL,
  PRIMARY KEY (`idEventoExcursion`),
  CONSTRAINT `fk_EventoExcursion_HorarioXExcursion1`
    FOREIGN KEY (`HorarioXExcursion_idHorarioXExcursion`)
    REFERENCES `mydb`.`HorarioXExcursion` (`idHorarioXExcursion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EventoExcursion_TipoVehiculo1`
    FOREIGN KEY (`TipoVehiculo_idTipoVehiculo`)
    REFERENCES `mydb`.`TipoVehiculo` (`idTipoVehiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`VisitanteXEvento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`VisitanteXEvento` (
  `Visitante_idVisitante` INT NOT NULL,
  `EventoExcursion_idEventoExcursion` INT NOT NULL,
  CONSTRAINT `fk_VisitanteXEvento_Visitante1`
    FOREIGN KEY (`Visitante_idVisitante`)
    REFERENCES `mydb`.`Visitante` (`idVisitante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_VisitanteXEvento_EventoExcursion1`
    FOREIGN KEY (`EventoExcursion_idEventoExcursion`)
    REFERENCES `mydb`.`EventoExcursion` (`idEventoExcursion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
