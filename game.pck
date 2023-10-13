GDPC                �                                                                         \   res://.godot/exported/133200997/export-4d084c79be29239e0a05f54c955b4913-ScreenBuilding.scn  @      �	      �dͅ-����=g%��v    P   res://.godot/exported/133200997/export-7866250ab10c77792eb483b1e0327b05-HUD.scn P'      k      ��fޖXW�����G(    \   res://.godot/exported/133200997/export-8757e310997156c9d702a200e0d8b5c1-BuildingsManager.scn�!      k      t�d�����&4��h    P   res://.godot/exported/133200997/export-bcb0d2eb5949c52b6a65bfe9de3e985b-Main.scn�3      	      ����a����u NՔ�    P   res://.godot/exported/133200997/export-c6af2f19286c0439c82492e6104b9251-Sun.scn �N      �      ,:�_Ga�r�1Q�3~�    ,   res://.godot/global_script_class_cache.cfg  �U      �       c��r�:݊�6g�m��    L   res://.godot/imported/Sprite-0002.png-be2d0c11222c1eca468919d34832f25a.ctex �E      �      *��]���kiΫ��l       res://.godot/uid_cache.bin  V      �       �	�$���ƇѼq��    $   res://BuildingsManager.tscn.remap   �S      m       �Ƿ���j����       res://HUD.tscn.remapPT      `       �/[=��z��	�Je�:       res://Main.tscn.remap   �T      a       3 J�M�B�b��}�       res://Sprite-0002.png.import�M      �       u�Э� <4���yU�       res://Sun.tscn.remap U      `       _��gY���A���       res://classes/Building.gd           �      Њ���O�)��8=�        res://classes/ScreenBuilding.gd �            M��%uM�v?����Y    (   res://classes/ScreenBuilding.tscn.remap pS      k       F�%��t�I��T���K       res://project.binary�V      �       ����K6�z��j��    $   res://scripts/BuildingsManager.gd         @      �nf_�2'�1��={       res://scripts/Frame.gd  P      -      S���d�,�ys:>��}       res://scripts/HUD.gd�      �      �۽��R�cRF�X8��       res://scripts/MouseBar.gd   �      [      ��~i_l��|���       res://scripts/Sun.gd�      �      ��4�����+��%��    $   res://scripts/SunEnergyManager.gd   �      :      �pfc���8�ŧy    �G������8d>class_name Building extends Timer

var cost: int = 0
var quantity: int = 0
var sunGained: int = 0
var basePrice: int = 0

func startBuilding(newCost, newSunGained, newTickTime):
	basePrice = newCost
	cost = newCost
	sunGained = newSunGained
	self.wait_time = newTickTime

func buildingMark1():
	self.wait_time /= 2

func buildingMark2():
	sunGained *= 2

func buildingMark3():
	self.wait_time /= 2

func buildingMark4():
	sunGained *= 2
�]X�=VĆ�N_extends ColorRect

@export var buildingTimer: Timer

func startBuilding():
	$ProgressBar.visible = true
	
func updateBuilding(newGain, newTime, newQuantity):
	$InfoWindow/Text/GainPerTick.text = str(newGain)
	$InfoWindow/Text/TickTime.text = str(newTime)
	$InfoWindow/Text/Quantity.text = str(newQuantity)
	
func _process(_delta):

	var timeLeft: float = buildingTimer.get_time_left()
	var totalTime: float = buildingTimer.get_wait_time()
	
	$ProgressBar/HowFull.set_size(Vector2(24, 96 * ((totalTime - timeLeft) / totalTime)))


func _on_mouse_entered():
	$InfoWindow.visible = true

func _on_mouse_exited():
	$InfoWindow.visible = false
RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script     res://classes/ScreenBuilding.gd ��������      local://PackedScene_87g3o          PackedScene          	         names "   $      PowerPlant    visible    anchor_right    anchor_bottom    offset_right    offset_bottom    grow_horizontal    grow_vertical    script 
   ColorRect    ProgressBar    layout_mode    anchors_preset    mouse_filter    Control    Background    anchor_left    anchor_top    offset_left    offset_top    color    HowFull 	   rotation    pivot_offset    InfoWindow    Text $   theme_override_font_sizes/font_size    text    Label    GainPerTick 	   TickTime 	   Quantity    _on_mouse_entered    mouse_entered    _on_mouse_exited    mouse_exited    	   variants    -               �?     ��     "�                                   B         ����   '1�   Jj�   �M�A   L7�?   q��C   �GD   H�*�   �Q8�   
�t>
�t>
�t>  �?     hB     �     �B   �I@
     @A  @B   ���>���>      �?     0�     ��     LB   ���>��L>      �?     ,�     d�         .   Ganho por tick: 
Tempo de tick: 
Quantidade:       �B     �B     �A      0      �B     �B     HB      0
      �B     �B     �B      node_count    
         nodes     �   ��������	       ����                                                                   
   ����                                                   	      ����      	      
                                                                          	      ����	                                                                           ����                                             	   	   ����                                                              ����                                           !                    ����            "      #      $             %                    ����            &      $      '      (             )                    ����            *      (      +      ,             %             conn_count             conns                !                          #   "                    node_paths              editable_instances              version             RSRC��Pextends Control

@export var buildings: Array = [Timer]
@export var sunEnergyManager: Node

signal buildingTick

func _ready():
	
	buildings[0] = $WindPower/WindPowerTimer
	buildings[0].startBuilding(25,1,10)

func completeBuildingTimer(value):
	buildingTick.emit(value)

#funções da usina eólica
func _on_wind_power_buy_button_down():
	if(sunEnergyManager.sunTotal < buildings[0].cost):
		return
	
	sunEnergyManager.sunTotal -= buildings[0].cost
	buildings[0].quantity += 1
	buildings[0].cost = roundi(buildings[0].basePrice )#* (1.15 ** buildings[0].quantity))
	
	sunEnergyManager.changeSunCountHUD()

	sunEnergyManager.changeBuildingPriceHUD(0, buildings[0].cost)
	
	if(buildings[0].quantity == 1):
		buildings[0].start()
		$WindPower/WindPowerPlant.visible = true
		$WindPower/WindPowerPlant.startBuilding()
	elif(buildings[0].quantity == 10):
		buildings[0].buildingMark1()
	elif(buildings[0].quantity == 25):
		buildings[0].buildingMark2()
	elif(buildings[0].quantity == 50):
		buildings[0].buildingMark3()
	elif(buildings[0].quantity == 100):
		buildings[0].buildingMark4()
	
	$WindPower/WindPowerPlant.updateBuilding(buildings[0].sunGained,
								$WindPower/WindPowerTimer.wait_time,
											  buildings[0].quantity)

func _on_wind_power_timer_timeout():
	completeBuildingTimer(buildings[0].sunGained * buildings[0].quantity)
	
extends Control

var screenSize = Vector2.ZERO

func _process(_delta):
	screenSize = get_viewport_rect().size
	$RightRect.set_size(Vector2(16, screenSize.y))
	$LeftRect.set_size(Vector2(390, screenSize.y))
	$UpRect.set_size(Vector2(screenSize.x, 16))
	$RightRect.set_size(Vector2(screenSize.x, 16))
	
Zb�extends Control

#funções de abrir e fechar o menu
func _on_open_menu_button_down():
	$Menu.visible = true
	$Buttons.visible = true
	$OpenMenu.visible = false

func _on_close_menu_button_down():
	$Menu.visible = false
	$Buttons.visible = false
	$OpenMenu.visible = true

#funções de mudar o valor da hud
func _on_sun_energy_manager_sun_tick(newSunAmount):
	$SunCount.text = str(newSunAmount)

func _on_sun_energy_manager_mouse_bought(newPrice, newSPT):
	$Buttons/MouseUpgrade/Price.text = str(newPrice)
	$Menu/SunPerTick.text = str(newSPT)

func _on_sun_energy_manager_building_bought(building, newPrice):
	if(building == 0):
		$Buttons/WindPowerBuy/Price.text = str(newPrice)

func _on_sun_time_elapsed(dayTime):
	$Time.text = str(dayTime) + ":00"
�J�ϴ�Il�(��w�extends Control

var isMouseInSun: bool = false
var sunTimer

func _ready():
	sunTimer = get_node("../../SunEnergyManager/SunTimer")

func _process(_delta):
	
	if(!isMouseInSun):
		return
	
	var timeLeft: float = sunTimer.get_time_left()
	var totalTime: float = sunTimer.get_wait_time()
	
	set_position(Vector2(get_global_mouse_position().x - 40, get_global_mouse_position().y))
	$HowFull.set_size(Vector2(24, 96 * ((totalTime - timeLeft) / totalTime)))
	

func _on_sun_mouse_entered():
	self.visible = true
	isMouseInSun = true

func _on_sun_mouse_exited():
	self.visible = false
	isMouseInSun = false
�TjTextends CharacterBody2D

@export var sunSpeed: int = 100
var screenSize = Vector2.ZERO
var dayTime: int = 6

signal timeElapsed

func _ready():
	#deixa o sol "clicavel"
	input_pickable = true
	
	#setup do movimento do sol
	const directionAngles: Array = [PI/4, 3*PI/4, 5*PI/4, 7*PI/4]
	var direction: Vector2 = Vector2(sunSpeed, 0).rotated(directionAngles[randi_range(0,3)])
	velocity = direction.move_toward(direction, sunSpeed)
	
	screenSize = get_viewport_rect().size
	
func _process(_delta):
	
	#método pra fazer o sol quicar nas bordas
	if(position.x >= screenSize.x || position.x <= 0):
		velocity.x = -velocity.x
	elif(position.y >= screenSize.y || position.y <= 0):
		velocity.y = -velocity.y
		
	#função pro sol mover
	move_and_slide()


func _on_day_cycle_timeout():
	dayTime += 1
	if(dayTime == 18):
		self.visible = false
	elif(dayTime == 24):
		dayTime = 0
	elif(dayTime == 6):
		self.visible = true
		
	timeElapsed.emit(dayTime)
v{'埊�'`��J�extends Node

@export var sunTotal: int = 0
var sunGainedPerTick: int = 1
var mouseCost: int = 10
var mouseUpgrades: int = 0

signal sunTick
signal mouseBought
signal buildingBought

func completeSunTick():
	sunTotal += sunGainedPerTick
	changeSunCountHUD()
	
#funções pra mudar os valores na hud
func changeSunCountHUD():
	sunTick.emit(sunTotal)
	
func changeMousePriceHUD():
	mouseBought.emit(mouseCost, sunGainedPerTick)
	
func changeBuildingPriceHUD(building, newPrice):
	buildingBought.emit(building, newPrice)

#funções pra começar e parar o timer do sol
func _on_sun_mouse_entered():
	$SunTimer.start()

func _on_sun_mouse_exited():
	$SunTimer.stop()

#funções de upgrade
func _on_mouse_upgrade_button_down():
	if(sunTotal < mouseCost):
		return
	
	mouseUpgrades += 1
	sunTotal -= mouseCost
	sunGainedPerTick += 1
	mouseCost = roundi(10 * (1.15 ** mouseUpgrades))
	changeSunCountHUD()
	changeMousePriceHUD()

#funções de timer
func _on_sun_timer_timeout():
	completeSunTick()

func _on_buildings_manager_building_tick(value):
	sunTotal += value
	changeSunCountHUD()
'�5�JRSRC                    PackedScene            ��������                                                  ..    WindPowerTimer    resource_local_to_scene    resource_name 	   _bundled    script       Script "   res://scripts/BuildingsManager.gd ��������   PackedScene "   res://classes/ScreenBuilding.tscn 
�R�yNt   Script    res://classes/Building.gd ��������      local://PackedScene_bcnju �         PackedScene          	         names "         BuildingsManager    layout_mode    anchors_preset    offset_right    offset_bottom    mouse_filter    script    Control 
   WindPower    Node    WindPowerPlant    offset_left    offset_top    color    buildingTimer    WindPowerTimer    Timer    _on_wind_power_timer_timeout    timeout    	   variants                         �D     "D                              �C     �C     *�     0�   ��K?��K?��K?  �?                            node_count             nodes     6   ��������       ����                                                    	      ����               ���
                        	      
           @                    ����                   conn_count             conns                                      node_paths              editable_instances              version             RSRCd&��RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    interpolation_mode    interpolation_color_space    offsets    colors    script 	   gradient    width    height    use_hdr    fill 
   fill_from    fill_to    repeat 	   _bundled       Script    res://scripts/HUD.gd ��������      local://Gradient_qoo1j           local://GradientTexture2D_pw30r H         local://PackedScene_6xrk6 �      	   Gradient       !      �"�>   $      ���>s� >      �?         GradientTexture2D                       �            PackedScene          	         names "   (      HUD    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    script    Control    Menu    visible    Frame 
   RightRect    anchor_left    offset_left    color 
   ColorRect    UpRect    offset_bottom 	   DownRect    anchor_top    offset_top 	   LeftRect    offset_right 
   CloseMenu $   theme_override_font_sizes/font_size    text    icon    flat 
   clip_text    icon_alignment    Button    SunPerTick    Label    Text 	   SunCount 	   OpenMenu    _on_close_menu_button_down    button_down    _on_open_menu_button_down    	   variants    (                    �?                                        ��          ���>��L>      �?   
        �A         	        �C     ��     `C            Fechar Menu                     �C     �B    ��C     �B      1      o�     ��     4B      Energia por tick:      XC     uC     �B   2         0      H�     ��   	   Energia:       Abrir Menu       node_count             nodes     -  ��������       ����                                                             	   ����   
                                                           ����                                                        ����	                                          	            
                    ����                                    
                    ����	                                                	      
                    ����                                    
                    ����                                                      	                                                  !       ����      	                                                  !   "   ����      	                                             !   #   ����      	                   !      "      #       
       !   "   ����      	      $      %      !      "      &                  $   ����                                                      	            '                                     conn_count             conns               &   %                     &   '                    node_paths              editable_instances              version             RSRCU�aI6RSRC                    PackedScene            ��������                                                  ..    SunEnergyManager    resource_local_to_scene    resource_name    blend_mode    light_mode    particles_animation    script    interpolation_mode    interpolation_color_space    offsets    colors 	   gradient    width    height    use_hdr    fill 
   fill_from    fill_to    repeat 	   _bundled       PackedScene    res://HUD.tscn ���ɾ�Na   Script    res://scripts/MouseBar.gd ��������   PackedScene    res://BuildingsManager.tscn �=����6   Script "   res://scripts/SunEnergyManager.gd ��������   PackedScene    res://Sun.tscn �e�i��eb   !   local://CanvasItemMaterial_0hwuq N         local://Gradient_etd4f q          local://GradientTexture2D_8p3oh �         local://PackedScene_oo6ct �         CanvasItemMaterial          	   Gradient    
   !      �P�>   $      ���>s� >      �?         GradientTexture2D                      m           PackedScene          	         names "   D      Main 	   material    Node2D    HUD    z_index    anchors_preset    anchor_right    anchor_bottom    offset_right    offset_bottom    grow_horizontal    grow_vertical    Buttons    visible    layout_mode    Control    MouseUpgrade    anchor_top    offset_left    offset_top $   theme_override_font_sizes/font_size    text    icon    flat 
   alignment    icon_alignment    Button    Price    horizontal_alignment    Label    WindPowerBuy 	   MouseBar    mouse_filter    script    Background    color 
   ColorRect    HowFull 	   rotation    pivot_offset    Time    BuildingsManager    sunEnergyManager    SunEnergyManager    Node 	   SunTimer    Timer    Sun 	   position    _on_mouse_upgrade_button_down    button_down    _on_wind_power_buy_button_down $   _on_buildings_manager_building_tick    buildingTick '   _on_sun_energy_manager_building_bought    buildingBought $   _on_sun_energy_manager_mouse_bought    mouseBought     _on_sun_energy_manager_sun_tick    sunTick    _on_sun_timer_timeout    timeout    _on_sun_mouse_entered    mouse_entered    _on_sun_mouse_exited    mouse_exited    _on_sun_time_elapsed    timeElapsed    	   variants    =                                                �D     "D                  �?     ��     "�                  ?      A     �B    ��C     @C              Melhorar o mouse                    ��C     pA    ��C     pB            10      �C        Comprar usina eólica     ��C     �A    ��C     tB      25          t��   �)C   �:�   �QC               �     �A     �B   
�t>
�t>
�t>  �?     �A     �B   �I@
     @A  @B   ���>���>      �?     �D     �D     �B   (         6:00                                         
    �6D  �C      node_count             nodes     +  ��������       ����                      ���                                       	      
                             ����	                        	      	      
   	      
                             ����                                             	                                                                 ����                           	                                         ����                                             	                                                                 ����                         !   	   "            #                          ����      $            %      &      '   	   (          !   )              $   "   ����            *      *      +   	   ,          #   -              $   %   ����            .   	   /   &   0   '   1          #   2                 (   ����            3            4   	   5      6      7                     ���)   8      *  @9               ,   +   ����   !   :              .   -   ����                ���/   ;      0   <             conn_count             conns     T         2   1                    2   3                    5   4                    7   6                    9   8                    ;   :                    =   <                    ?   >                    ?   >                    A   @                    A   @                    C   B                    node_paths              editable_instances              version             RSRC��l�B`�GST2   �   @      ����               � @        �  RIFF�  WEBPVP8L�  /�O�0����Q��4�P�@жm\�?�/۶�D��O|�	�m*2���p��;��F׸c�u��r^��!Ø8DD ���1�F "b0�e"	�S%�f�#Hr��A��D���}<>~�0���򻗀���崭���ԍZK�������V�,B��J�!V�bJ��5{�����93#�������l�`�4�ްUBw�[B%Nuk�^�u�|��JU�M��]o���^�"Uʕnܑ���n?;��6�+��r�I��
�W�+D�ȝ�Hj7[*m��@�h2�����o�P�/�q%ȄQ��'�|���� ��PQ�!"�'Hq<"%Z� ���]o��ԩ�㌇��`������?�(��� ��� i8��V?�2�%c�X���3����*�Н�� :B�_З/�/_��J5`̱6UA0�Rk�֢�(�r������|߻v]�q�qQ��Ƥ9>~�`ᖀ2�I�ZϘ�Z�p�����Z�.5�QB��L�2O�H��X��{�<��t��/f���t��t��[--��Q'D9��Px��kٮ��|��0�$M�����_I��8;�����u��k��6$���t�a๮�Ug�ei���bq�\��~GZ!-��EQ�qi�eӎj{�� 3��(�I��ٮ��T�4K_�Ea�{�v����bty�^�}k�+��u��v���P�Ӄ���x����mwgY:�u-����@��>c�Bi>O�Y���rmT�?AP�J��$����j�4}����
z�y��q�u�f����t_�=d4L���0�ն������lڭ��Y�1/`�^C�2��!�t��RX��E�1�=j�l⧄hخ���ft>h6�]5{����`���{p�����W3���M��ߟ�$�!`�Ҿ��>� n�FD��/���O�|Ⱦ߻�Z���Eh�mS9�?�����$/�P/%�2�3�"?�)OF!ظ}8��2�/��n7�[Z��E�B4��0avx�*�{�U�9�+�^B67���L��ލ�x�pS�8�y�����,W�f�k����/�������TO�x��x*�!%�f��P�"�Ե���!w����w�ⷵ�������"���s'�`��m:_��4���*<l��O�/n���t��f��-%滇)q��n�J�A�f��A7��AQ<�1��$�X���I���e���;����q���my��p��>�޿���c��-�������w�}�'I<��������5��wu>�b���v����CwW�^���� h���ۨ���L��M��!Y�
{�2�5�?�a�ڏf�Ǽ�@�\����!rQ��٣vˆ���6��Xͦ�zm���ϋ���jK�=bᳺ�����rQ����}��\˲ݡ�bF���x�eY���mwgY:� ƮޢVs�`�}������l�mﶰ����X�bc�@F��)�9���y����d�C�P[��촣Ԟ���!J'bҘ����X������L�,M�gg��C�I��1O�����4˦��=׵�(NƢ䢾��d)����.���V=����WR�4�<�{�b:�t�򽖋�{�(�#~h�n$0�F�$�5��=�8����Ёq/f������<��;N/���дV��I0B@�%�%0�}bu��y_S�^pi2F��dn1�!Ѱ�![
�� �(�Д˭-$�ư�5�? ��>+tw� �#��$ѷ;	���`H��F�)Q�<��\c\�r�MB#X�ŌF�	�+p��)�{�44�iRZ�d%��� ˘*�VR�9&�&
����n�9Y�AC��@m�%\J�T����VI"p%h�R�+%���5�ĕ4%~�y�T�=Ldn@\J=	��?�Q+%��R�k�d�@��׻a�ģ�g=�{(N�c[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://ditkpwp5fkido"
path="res://.godot/imported/Sprite-0002.png-be2d0c11222c1eca468919d34832f25a.ctex"
metadata={
"vram_texture": false
}
 9n�!���RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    radius    height    script 	   _bundled       Script    res://scripts/Sun.gd ��������
   Texture2D    res://Sprite-0002.png �mӆ�L�k      local://CapsuleShape2D_cq0rq �         local://PackedScene_8m61y �         CapsuleShape2D            HB        4C         PackedScene          	         names "         Sun    script    CharacterBody2D    CollisionShape2D 	   rotation    shape    debug_color 	   DayCycle 
   autostart    Timer 	   Sprite2D 	   position    scale    texture    _on_day_cycle_timeout    timeout    	   variants                    ��?             ��5?	��>    ���>      
   e  ?  `5
    �?  �?               node_count             nodes     ,   ��������       ����                            ����                                 	      ����                     
   
   ����                               conn_count             conns                                      node_paths              editable_instances              version             RSRC�y+]�M_�n[remap]

path="res://.godot/exported/133200997/export-4d084c79be29239e0a05f54c955b4913-ScreenBuilding.scn"
t�]�[remap]

path="res://.godot/exported/133200997/export-8757e310997156c9d702a200e0d8b5c1-BuildingsManager.scn"
�ϻ[remap]

path="res://.godot/exported/133200997/export-7866250ab10c77792eb483b1e0327b05-HUD.scn"
[remap]

path="res://.godot/exported/133200997/export-bcb0d2eb5949c52b6a65bfe9de3e985b-Main.scn"
�提��)
J�}݈�[remap]

path="res://.godot/exported/133200997/export-c6af2f19286c0439c82492e6104b9251-Sun.scn"
list=Array[Dictionary]([{
"base": &"Timer",
"class": &"Building",
"icon": "",
"language": &"GDScript",
"path": "res://classes/Building.gd"
}])
�   
�R�yNt!   res://classes/ScreenBuilding.tscn�=����6   res://BuildingsManager.tscn���ɾ�Na   res://HUD.tscn���#   res://Main.tscn�e�i��eb   res://Sun.tscn�mӆ�L�k   res://Sprite-0002.png��d��WbECFG      application/config/name         Projeto Alvorada   application/run/main_scene         res://Main.tscn    application/config/features$   "         4.1    Forward Plus    