CREATE DATABASE IF NOT EXISTS mydb;
USE mydb;

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `age` int(3) NOT NULL,
  PRIMARY KEY (`id`)
);

INSERT INTO `users` (`name`, `email`, `age`) VALUES
('Sonny Corleone', 'sonny@gmail.com', '29');

INSERT INTO `users` (`name`, `email`, `age`) VALUES
('Tony Montana', 'scar@gmail.com', '39');

INSERT INTO `users` (`name`, `email`, `age`) VALUES
('Billy Batts', 'batts@gmail.com', '57');