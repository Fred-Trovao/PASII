<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="exibe-texto-em-lua-5-lendo-txt-de-http" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
	<head>
		<regionBase>
			<region id="rgIcone" height="80%" width="80%" top="15%" zIndex="1"/>
			<region id="rgTexto" height="50%" width="100%" top="15%" zIndex="2"/>
		</regionBase>
		<descriptorBase>
			<descriptor id="dIcone" region="rgIcone" explicitDur="2s"/>
			<descriptor id="dTexto" region="rgTexto"/>
		</descriptorBase>
		<connectorBase>
			<importBase documentURI="../ConnectorBase.ncl" alias="conn"/>
			<causalConnector id="onEndAttributionSet">
				<connectorParam name="value"/>
				<simpleCondition role="onEndAttribution"/>
				<simpleAction role="set" value="$value"/>
			</causalConnector>
			
			<causalConnector id="onEndAttributionTestStartN">
				<connectorParam name="value"/>
				<compoundCondition operator="and">
					<simpleCondition role="onEndAttribution"/>
					<assessmentStatement comparator="eq">
						<attributeAssessment role="attNodeTest" eventType="attribution" attributeType="nodeProperty"/>
						<valueAssessment value="$value"/>
					</assessmentStatement>
				</compoundCondition>
				<simpleAction role="start" max="unbounded" qualifier="par"/>
			</causalConnector>
		</connectorBase>
	</head>
	<body>
		<port id="porta" component="icone"/>
		<media id="icone" src="../media/icon.png" descriptor="dIcone"/>
		<media id="interatividade" src="../media/interatividade.png" descriptor="dIcone">
			
		</media>
		<media id="leitorDeMensagem" src="script/readTextFromHtml.lua">
			<property name="mensagem"/>
		</media>
		<media id="exibidorDeTexto" src="script/show-text-from-set-property.lua" descriptor="dTexto">
			<property name="texto"/>
		</media>
		<link xconnector="conn#onBeginStartN">
			<bind role="onBegin" component="icone"/>
			<bind role="start" component="exibidorDeTexto"/>
			<bind role="start" component="leitorDeMensagem"/>
		</link>
		<link xconnector="onEndAttributionSet">
			<bind role="onEndAttribution" component="leitorDeMensagem" interface="mensagem"/>
			<bind role="set" component="exibidorDeTexto" interface="texto">
				<bindParam name="value" value="$msg"/>
			</bind>
			<bind role="msg" component="leitorDeMensagem" interface="mensagem"/>
		</link>
		
		<link xconnector="onEndAttributionTestStartN">
			<bind role="onEndAttribution" component="leitorDeMensagem" interface="mensagem"/>
			<bind role="attNodeTest" component="leitorDeMensagem" interface="mensagem">
				<bindParam name="value" value="15"/>				
			</bind>
			<bind role="start" component="interatividade" />			
		</link>
	</body>
</ncl>
