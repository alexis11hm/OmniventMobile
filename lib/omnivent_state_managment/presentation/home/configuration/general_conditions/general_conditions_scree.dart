import 'package:flutter/material.dart';
import 'package:omnivent_app_wireframe/omnivent_state_managment/colors.dart';

class GeneralConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final headerStyle = TextStyle(
        color: OmniventColors.naranja,
        fontSize: 18,
        fontWeight: FontWeight.bold);
    final secondaryHeaderStyle =
        TextStyle(fontSize: 14, fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: AppBar(
        title: Text('Condiciones Generales'),
        backgroundColor: OmniventColors.azulMarino,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Contrato de Licenciamiento y Uso', style: headerStyle),
              SizedBox(height: 20),
              Text(
                  'EL PRESENTE CONTRATO LO CELEBRAN EL USUARIO FINAL QUE EN LO SUCESIVO SE DENOMINARÁ "CLIENTE" Y POR OTRA PARTE OMNISOFT TECHNOLOGIES S. DE R.L. EN LO SUCESIVO "OMNISOFT", REGULA LA LICENCIA DE SOFTWARE PARA EL PRODUCTO OMNIVENT PUNTO DE VENTA EN CUALESQUIERA DE SUS EDICIONES TANTO PRESENTES COMO FUTURAS, QUE EN LO SUCESIVO SE DENOMINARÁ "OMNIVENT" O SIMPLEMENTE EL "SOFTWARE". MEDIANTE LA FIRMA DEL PRESENTE, LA DESCARGA DEL SOFTWARE, LA ROTURA DEL SELLO QUE SE ENCUENTRE EN EL MEDIO DE INSTALACIÓN, O PULSANDO EN EL BOTON "ACEPTO", EL CLIENTE ACEPTA Y QUEDA VINCULADO POR LOS TÉRMINOS DEL PRESENTE CONTRATO. SI EL USUARIO NO ACEPTA LOS TÉRMINOS DEL PRESENTE CONTRATO, NO DEBERÁ ROMPER EL SELLO DEL CD, O EN SU CASO DEBE PULSAR EN EL BOTON "NO ACEPTO", Y DEVOLVER DE INMEDIATO A OMNISOFT EL SOFTWARE Y DEMAS ELEMENTOS QUE LO ACOMPAÑEN. LAS PARTES ACUERDAN SOMETERSE A LAS SIGUIENTES'),
              SizedBox(height: 20),
              Text('CLAUSULAS', style: secondaryHeaderStyle),
              SizedBox(height: 20),
              Text('I. EL SOFTWARE', style: secondaryHeaderStyle),
              SizedBox(height: 20),
              Text(
                  'OMNIVENT consta -de manera enunciativa más no limitativa- de un módulo de Punto de Venta, un módulo de Back Office, un Sistema Manejador de Base de Datos, archivos de configuración, así como manuales, técnicas, herramientas de Software, formatos, diseños, conceptos, métodos e ideas asociados al software y a toda la documentación relacionada con el mismo.'),
              SizedBox(height: 20),
              Text('II. CONTRATO DE LICENCIA', style: secondaryHeaderStyle),
              SizedBox(height: 20),
              Text(
                  'Este es un contrato de licencia de uso y no un contrato de venta. OMNISOFT es propietario o posee la licencia de otros fabricantes, copyrights del Software. Excepto lo manifestado en este contrato, al CLIENTE no se le concede ningún derecho sobre el software, ya sea de patentes, copyright, nombres comerciales, marcas registradas (tanto si ya están registradas como sin registrar), ideas originales o ningún otro derecho, franquicias o licencias en lo que se refiere al Software. El título del Software y cualquier copia hecha de él están en poder de OMNISOFT o sus filiales.'),
              SizedBox(height: 20),
              Text('III. MODALIDADES DE LICENCIAMIENTO', style: secondaryHeaderStyle),
              SizedBox(height: 20),
              Text(
                  'El uso de OMNIVENT se encuentra regulado por dos modalidades diferentes de licenciamiento: compra de licencia permanente o arrendamiento del software. \n\nCOMPRA DE LICENCIA PERMANENTE\n\n Consiste en la adquisición de una licencia de uso la cual estará limitada por tiempo mientras el CLIENTE no haya liquidado en su totalidad el importe de la misma. Durante el periodo de tiempo que haya acordado con OMNISOFT para la liquidación de la licencia, el CLIENTE recibirá licencias temporales, las cuales tendrán la misma vigencia que el periodo de pago cubierto.  Si el CLIENTE se atrasa en sus pagos, el software dejará de funcionar sin que OMNISOFT asuma responsabilidad alguna por los daños que pudiera ocasionar la interrupción de la operación del software. Una vez cubierto la totalidad del costo de la licencia, el CLIENTE recibirá de OMNISOFT una licencia permanente.\n\nARRENDAMIENTO\n\nBajo esta modalidad, el CLIENTE recibirá una licencia temporal, la cual cubrirá el periodo o parcialidad acordada con OMNISOFT, al término de la cual expirará y el software dejará de operar sin que OMNISOFT asuma responsabilidad alguna por los daños que pudiera ocasionar la interrupción en la operación del software.  El CLIENTE recibirá nuevas licencias conforme vaya liquidando los periodos correspondientes, y podrá continuar así de forma indefinida, pudiendo terminar la relación previo aviso a OMNISOFT o bien al adquirir una licencia permanente previa liquidación del importe de la misma.'),
              SizedBox(height: 20),
              Text('IV. LICENCIA', style: secondaryHeaderStyle),
              SizedBox(height: 20),
              Text(
                  'Bajo cualquier de las modalidades descritas en la cláusula III, OMNISOFT otorga al CLIENTE una licencia limitada, no exclusiva e intransferible para:\n\n1.	Instalar y utilizar el Software en una única computadora.\n2.	Utilizar el software solamente para el uso habitual de la entidad donde es instalado.\n3.	Realizar copias de las bases de datos generadas por el software para fines de respaldo y seguridad de la información del CLIENTE.\n4.	Reinstalar el software en el mismo equipo donde se instaló por primera vez, o bien en un equipo diferente, previa notificación a OMNISOFT para que se indique al CLIENTE el procedimiento correspondiente.\n5.	Transferir a un tercero la posesión del software, transfiriendo una copia de este contrato y toda la documentación, junto con una copia inalterada del software, a condición de que:\n\n  a)	El importe de la licencia haya sido cubierto totalmente.\n  b)	OMNISOFT debe ser notificado inmediatamente de dicho traspaso.\n  c)	Se entienda claramente como transferencia del software, no como una copia o réplica para el tercero o computadora adicional.\n  d)	El CLIENTE deberá desinstalar OMNIVENT de su computadora.\n e)	Dicha transferencia de posesión finaliza su licencia otorgada por OMNISOFT.\n f)	La otra parte debe aceptar y estar al corriente de los términos de la licencia para el uso del software, y\n  g)	No deberá utilizar el Software e ideas del mismo para fines comerciales ni después de finalizado el plazo de la licencia.'),
              Text('V. LIMITACIONES DE LA LICENCIA', style: secondaryHeaderStyle),
              SizedBox(height: 20),
              Text(
                  '1. El CLIENTE no deberá, sin el consentimiento escrito de OMNISOFT:\n\na)	Usar, copiar, modificar, mezclar, transferir, traducir, alquilar, arrendar, sub-licenciar o transferir de cualquier otra forma copias de OMNIVENT excepto como aquí se proporciona. \nb)	Usar, copiar, modificar, mezclar transferir o traducir la configuración o compilación del Software excepto según lo permitido por la ley.  \nc)	Licencia e instalación a terceros, alquiler o distribución del Software o cualquier copia de él.  \nd)	Realizar o permitir que se realice ingeniería inversa o des compilación de parte o todo el Software.  \ne)	Prestar servicios de procesamiento de información, de centro de negocios, de tiempo compartido de recursos informáticos o servicios similares para terceros, o utilizar el Software para procesar datos de terceros. \nf)	Instalar en Red el software a menos de adquirir con OMNISOFT las licencias necesarias para dicho efecto y solicitar la configuración de esta funcionalidad. \ng)	Exigir funcionalidades adicionales al Software no adquiridas en la licencia instalada, a menos de solicitar y pagar a OMNISOFT el importe por dicha adhesión.  \nh)	Re-Instalar deliberadamente la licencia obtenida sin conocimiento y autorización de OMNISOFT.  \n\n2. El CLIENTE no exportará ni re-exportará el software en cualquier forma, bajo violación de las limitaciones de exportación por el gobierno de su país.'),
              SizedBox(height: 20),
              Text('VI. GARANTÍA LIMITADA', style: secondaryHeaderStyle),
              SizedBox(height: 20),
              Text(
                  'OMNISOFT garantiza que OMNIVENT funcionará sustancialmente de conformidad con las características incluidas en el software y el CLIENTE dispondrá de (90) NOVENTA DÍAS naturales contados a partir de la fecha de entrega/instalación del software para realizar cualquier reclamación relacionada con funcionamiento anormal del software. La garantía quedará anulada en caso de que el CLIENTE incumpla cualquier obligación prevista en el presente contrato, o en caso de modificaciones al software realizadas por terceros distintos de OMNISOFT.'),
              SizedBox(height: 20),
              Text('VII. VALIDACIÓN DE LA GARANTÍA', style: secondaryHeaderStyle),
              SizedBox(height: 20),
              Text(
                  'Para efectuar una reclamación durante el periodo de garantía, el CLIENTE deberá notificar al lugar donde lo adquirió, anexando comprobante de compra. En caso de que se verifique por parte de OMNISOFT que ésta es procedente de acuerdo a la documentación del software, OMNISOFT se compromete a reparar o sustituir el software con las anomalías, siempre y cuando se haya notificado a OMNISOFT dentro del periodo de validez de la garantía y sin costo alguno para el CLIENTE.'),
              SizedBox(height: 20),
              Text('VIII. LIMITACIÓN DE RESPONSABILIDAD POR DAÑOS', style: secondaryHeaderStyle),
              SizedBox(height: 20),
              Text(
                  'En ningún caso OMNISOFT, será responsable por daños indirectos, especiales, financieros, incidentales, o consecuentes, de cualquier tipo (incluyendo, sin carácter limitativo: daños por pérdida de beneficios, interrupción de actividad, pérdida de información comercial, fallas de hardware, sistema operativo del ordenador o cualquier otro daño pecuniario, fortuito o consecuente que resulte del uso o de la imposibilidad de utilizar OMNIVENT, o de la prestación o falta de prestación de los servicios de soporte, incluso en caso de que OMNISOFT o sus Vendedores Autorizados hubiesen sido avisados de la posibilidad de producirse dichos daños o de cualquier demanda suya basada en una demanda de terceros. En ningún caso la responsabilidad de OMNISOFT derivada o en relación con el presente contrato excederá el importe pagado por OMNIVENT. En la medida en que así lo permita la ley, las acciones contra OMNISOFT derivadas del incumplimiento de cualquier obligación del presente contrato deberán ejercerse en el plazo máximo de un año a partir de la fecha en que se produjo el hecho que dio lugar a la acción. Las disposiciones de la presente cláusula no limitarán en ningún caso la responsabilidad por dolo de OMNISOFT o por muerte o lesiones. Algunas jurisdicciones no permiten la exclusión o limitación de responsabilidad por daños consecuentes o incidentales, por lo que dichas exclusiones o limitaciones podrían no aplicarse a su caso.'),
              SizedBox(height: 20),
              Text('IX. CONFIDENCIALIDAD EN LA INFORMACIÓN DEL CLIENTE', style: secondaryHeaderStyle),
              SizedBox(height: 20),
              Text(
                  'La información que el CLIENTE proporcione a OMNISOFT será mantenida confidencialmente y usada para soportar la relación con el CLIENTE al menos con la misma diligencia con la que OMNISOFT protege su información confidencial de posibles exposiciones al público. OMNISOFT utilizará las medidas humanas y recursos tecnológicos que considere necesarios para proteger la información confiada por el CLIENTE contra ataques e intentos de filtración por terceros no autorizados. Las filiales o empresas autorizadas para la distribución de OMNIVENT que tengan acceso a su información personal, son requeridas a mantener la información confidencial y no usarla para ningún otro propósito diferente que llevar a cabo los servicios de OMNISOFT. OMNISOFT no proporcionará ninguna información, a menos que sea juzgado conveniente, actuando de buena fe para: \n\na)	Cumplir con procesos legales \nb)	Hacer cumplir el presente contrato \nc)	Responder a reclamos por acciones que menoscaben los derechos de terceros \nd)	Proteger los derechos, la propiedad, la seguridad de OMNISOFT, sus clientes y el público en general. '),
              SizedBox(height: 20),
              Text('X. CONFIDENCIALIDAD EN LA INFORMACIÓN DE OMNISOFT', style: secondaryHeaderStyle),
              SizedBox(height: 20),
              Text(
                  'Los términos del presente contrato y toda la información que se encuentre marcada como "confidencial" que se proporcione con arreglo al presente contrato tienen carácter confidencial y el CLIENTE no puede revelarla, ya sea oralmente o por escrito, sin el previo consentimiento por escrito de OMNISOFT y deberá protegerla al menos con la misma diligencia y grado de confidencialidad que usa para proteger su información confidencial frente a posibles revelaciones al público.\n\nNinguna de las partes tendrá obligación de confidencialidad con respecto a información que sea o llegue a ser de dominio público sin que medie acción u omisión de dicha parte, obrase legalmente en poder de dicha parte antes de su divulgación y no hubiese sido proporcionada directa o indirectamente por la otra parte, es revelada a dicha parte por un tercero no vinculado por obligaciones de confidencialidad, es desarrollada independientemente por dicha parte sin tener acceso a la información confidencial, o cuya revelación sea exigida por la legislación aplicable o en virtud de orden judicial o administrativa.'),
              SizedBox(height: 20),
              Text('XI. USO E IMPLEMENTACIÓN', style: secondaryHeaderStyle),
              SizedBox(height: 20),
              Text(
                  'El CLIENTE es responsable del uso e implementación de OMNIVENT, salvo las acciones contratadas con OMNISOFT con fines de instalación y mantenimiento. Los tiempos, procedimientos y recursos destinados a la utilización de OMNIVENT serán de acuerdo a lo que al CLIENTE le convenga y aplique particularmente. OMNISOFT puede sugerir las mejores prácticas de implementación, hardware complementario y procedimientos sugeridos, pero no es responsable del uso e implementación que el CLIENTE decida, ni demerita las funcionalidades del software adquirido. \nOMNISOFT no es responsable por daños de cualquier índole, pérdida de información, inconsistencias operativas y/o en la información, seguridad lógica y física de los equipos donde se encuentre instalado OMNIVENT, o cualquier otra situación que surja como consecuencia de la falta de conocimiento, inhabilidad y/o errores operativos directamente imputables al CLIENTE en la operación de OMNIVENT.  OMNISOFT no tendrá responsabilidad alguna para restaurar, corregir o revertir los daños originados por tales situaciones, siendo responsabilidad absoluta del CLIENTE tomar las medidas necesarias para prevenirlas y/o corregirlas.'),
              SizedBox(height: 20),
              Text('XII. CANCELACIONES', style: secondaryHeaderStyle),
              SizedBox(height: 20),
              Text(
                  'Si el CLIENTE no está de acuerdo con estos términos y condiciones, no deberá utilizar el software, no comenzar la descarga del software, o pulsar el botón "No Acepto", debiendo notificar por escrito a OMNISOFT, devolver los manuales, la documentación entregada y software sin utilizar dentro de los (10) diez días naturales siguientes a su recepción, para la devolución de cualesquiera honorarios pagados en concepto de utilización de los productos.  Pasado este tiempo, el CLIENTE deberá pagar el 10% del importe total de las licencias adquiridas por concepto de gastos administrativos, y demás pagos que se deriven del acuerdo comercial establecido con OMNISOFT a la fecha de aviso de la cancelación.  Esta cláusula no tendrá efecto para la modalidad de Arrendamiento, en la cual no se aceptan cancelaciones.'),
              SizedBox(height: 20),
              Text('XIII. INCUMPLIMIENTOS DE PAGO', style: secondaryHeaderStyle),
              SizedBox(height: 20),
              Text(
                  'En caso de que el CLIENTE incumpla en sus obligaciones de pago, OMNISOFT a su entera discreción, se reserva el derecho de revocar la licencia otorgada al CLIENTE, restringir el acceso a OMNIVENT así como los servicios y/o productos adicionalmente adquiridos. El atraso en uno o más pagos hace exigible el importe total adeudado con los intereses moratorios que correspondan y los gastos de cobranza derivados.'),
              SizedBox(height: 20),
              Text('XIV. FUNCIONALIDADES ADICIONALES', style: secondaryHeaderStyle),
              SizedBox(height: 20),
              Text(
                  'El CLIENTE puede solicitar a OMNISOFT el agregado de nuevas características siguiendo el procedimiento que OMNISOFT le indique para dicho fin.  Las peticiones de modificaciones o agregado de nuevas funcionalidades o en general cualquier alteración al software pasará por un proceso de evaluación por parte de OMNISOFT, quien a su entera discreción determinará si los cambios solicitados resultan en un beneficio general para los clientes o para OMNIVENT, en cuyo caso se programará la implementación de dichos cambios y el CLIENTE tendrá derecho a una actualización sin costo alguno.  En caso de que OMNISOFT determine que los cambios solo representan un beneficio particular para el CLIENTE que los solicita, OMNISOFT cobrará por la modificación de acuerdo a las tarifas actuales que existan en ese momento por concepto de consultoría y será decisión del CLIENTE pagar por dichos cambios o declinar la solicitud.'),
              SizedBox(height: 20),
              Text('XV. FINALIZACIÓN', style: secondaryHeaderStyle),
              SizedBox(height: 20),
              Text(
                  'Usted puede finalizar su licencia en cualquier momento destruyendo el Software y todas sus copias o según lo descrito en estas condiciones. OMNISOFT puede finalizar su licencia si usted no cumple con estas condiciones. Sobre tal fin, usted acuerda destruir todas sus copias de OMNIVENT. Cada una de las partes puede disolver el presente Contrato en caso de que la otra incumpla sus obligaciones en virtud del mismo y dicho incumplimiento no se subsane dentro de (30) treinta días a contar de la recepción de un requerimiento escrito a tal efecto. Después de la resolución del presente Contrato, el CLIENTE cesará inmediatamente en el uso del Software y devolverá a OMNISOFT todas las copias del mismo junto a toda la documentación, certificando por escrito la devolución de la totalidad de las copias, dentro de los (5) cinco días laborables después de la resolución. Lo dicho bajo sustento de gastos administrativos que aplique a favor de OMNISOFT. El presente Contrato se rige por las leyes de La República Mexicana, con independencia de las normas de derecho internacional privado de dicho País. En caso de que se declare la ineficacia cualquiera de las disposiciones del presente Contrato, dicha declaración no afectará la validez de las demás disposiciones del presente Contrato. Las partes acuerdan que el Convenio de las Naciones Unidas sobre Contratos de Compraventa Internacional de Bienes no será aplicable al presente Contrato. El CLIENTE no exportará o reexportará, directa o indirectamente, OMNIVENT a ningún País en caso de que dicha trasferencia esté prohibida por las Leyes de Control a la Exportación de México y los correspondientes reglamentos de desarrollo o por cualquier otra regulación aplicable en materia de control a la exportación. El CLIENTE no cederá o sub-licenciará, parcial o totalmente, ninguno de sus derechos u obligaciones en virtud del presente Contrato sin el previo consentimiento escrito de OMNISOFT. Cualquier cesión o sub-licencia no autorizada del presente Contrato será nula. Sujeto a las disposiciones anteriormente expuestas, el presente Contrato obligará y se reputará en beneficio de las partes y sus sucesores y cesionarios autorizados. Cualquier consulta relativa al presente Contrato deberá dirigirse a OMNISOFT a la dirección y número de teléfono indicados al final de este contrato.'),
              SizedBox(height: 20),
              Text('XVI. LEY GOBERNANTE', style: secondaryHeaderStyle),
              SizedBox(height: 20),
              Text(
                  'Ambas partes acuerdan que cualquier disputa a raíz del incumplimiento del presente contrato será resuelto con mediación y arbitraje de los juzgados y tribunales de la Ciudad de México, Distrito Federal, México, con renuncia expresa del fuero que pudiera corresponderles.'),
              SizedBox(height: 20),
              Text(
                  'EL CLIENTE RECONOCE QUE HA LEÍDO ESTE CONTRATO, COMPRENDIÉNDOLO Y ACUERDA COMPROMETERSE CON SUS TÉRMINOS Y CONDICIONES. NINGUNA DE LAS DOS PARTES SE COMPROMETE POR LAS DECLARACIONES O REPRESENTACIONES NO CONTENIDAS EN ESTE CONTRATO. NINGÚN CAMBIO SERÁ EFECTIVO EN ESTE ACUERDO A MENOS QUE SEA POR ESCRITO Y FIRMADO POR LOS REPRESENTANTES DEBIDAMENTE AUTORIZADOS DE CADA UNA DE LAS PARTES. CON LA APERTURA DEL PAQUETE, USTED ACUERDA ACEPTAR LOS TÉRMINOS DE ESTE CONTRATO.', style: secondaryHeaderStyle),
              SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
