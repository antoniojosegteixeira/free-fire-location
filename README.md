# Free Fire Location

![image](https://user-images.githubusercontent.com/75284432/216848055-b130beb1-aa06-4d9d-9bc9-988d7c2fd025.png)


FreeFireLocation é um aplicativo em Flutter para localização de incêndios em tempo real. Consome dados de satélites do INPE e NASA, além de prover informações sobre o tempo local. Usuários podem contribuir adicionando ocorrências de incêndio.

O aplicativo tem como objetivo mapear focos de incêndio a partir de dados de satélite coletados a partir do Instituto Nacional de Pesquisas Espaciais (INPE) e NASA (National Aeronautics and Space Administration), atualizados periodicamente a partir de 10 minutos. Visa principalmente auxiliar motoristas, moradores rurais e possivelmente corpo de bombeiros, indicando locais próximos afetados por queimadas. 

É construído em padrão DDD (Domain Driven Design). As injeções de dependência são gerenciadas por GetIt e o gerenciador de estados de escolha foi Cubit. Seu back-end é construído em Firebase. Testes unitários foram realizados utilizando Mockito.

