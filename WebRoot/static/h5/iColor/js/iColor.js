/*! iColor v10.11.2011 levi | http://levi.cg.am */
(function ()
{
    function iColor($elem,arg,elemIndex, feedback)
    {	
        var $this, type = typeof arg, 
            $iColor = $('#iColorPicker'+elemIndex).length ? $('#iColorPicker'+elemIndex) : initColor(elemIndex)
            op = 
            {
                start: function() {},
                coord: coord,
                callback: null,
            };
            fd = feedback;
         
        if (type == 'function')
        {
            op.callback = arg;
        }
        else if (type == 'object') $.extend(op, arg);
         
        return $elem.each(function()
        {
            op.start($(this));
            $(this).click(function()
            {
                $this = $(this);
                op.coord($(this), $iColor);
                 
                $iColor.find('td').mouseover(mouseover).click(selected);
                $(document).bind('click', closed);
            });
        });
         
        function coord($elem, $panel)
        {
            offset = $elem.offset()
            $panel.css(
            {
                'top': offset.top + $elem.outerHeight() - $panel.outerHeight() + 'px',
                'left': offset.left + $elem.outerWidth() + 'px',
                'position': 'absolute'
            })
            .fadeIn('fast');
        }
         
        function mouseover(evt)
        {
            var hx = '#' + $(this).attr('hx');
            $('#colorPreview'+elemIndex).css('background', hx);
        }
         
        function selected(evt)
        {
            /*if (op.callback == null)
            {
                var hx = '#' + $(this).attr('hx');
                $this.css('background', hx);
            }
            else op.callback($this, evt, $(this));*/
        	if (feedback == null)
            {
                var hx = '#' + $(this).attr('hx');
                $this.css('background', hx);
            }
            else feedback($this, evt, $(this));
        	
        }
         
        function closed(evt)
        {
            var closed = false;
            if (evt.target == $('#iColorPicker'+elemIndex)[0]) closed = true;
            /*if($elem.selector != "#"+evt.target.id){
            	return;
            }*/
            $elem.each(function(index, element) { if (evt.target == $(this)[0]) closed = true; });
            if (!closed) 
            {
                $(document).unbind('click', closed);
                $iColor.fadeOut().find('td').unbind('mouseover', mouseover).unbind('click', selected);
            }
        }
    }
     
    var initColor = function(elemIndex)
    {
        var hx = 
        [
            'f00', 'ff0', '0f0', '0ff', '00f', 'f0f', 'fff', 'ebebeb', 'e1e1e1', 'd7d7d7', 'ccc', 'c2c2c2', 'b7b7b7', 'acacac', 'a0a0a0', '959595', 
            'ee1d24', 'fff100', '00a650', '00aeef', '2f3192', 'ed008c', '898989', '7d7d7d', '707070', '626262', '555', '464646', '363636', '262626', '111', '000',
            'f7977a', 'fbad82', 'fdc68c', 'fff799', 'c6df9c', 'a4d49d', '81ca9d', '7bcdc9', '6ccff7', '7ca6d8', '8293ca', '8881be', 'a286bd', 'bc8cbf', 'f49bc1', 'f5999d',
            'f16c4d', 'f68e54', 'fbaf5a', 'fff467', 'acd372', '7dc473', '39b778', '16bcb4', '00bff3', '438ccb', '5573b7', '5e5ca7', '855fa8', 'a763a9', 'ef6ea8', 'f16d7e',
            'ee1d24', 'f16522', 'f7941d', 'fff100', '8fc63d', '37b44a', '00a650', '00a99e', '00aeef', '0072bc', '0054a5', '2f3192', '652c91', '91278f', 'ed008c', 'ee105a',
            '9d0a0f', 'a1410d', 'a36209', 'aba000', '588528', '197b30', '007236', '00736a', '0076a4', '004a80', '003370', '1d1363', '450e61', '62055f', '9e005c', '9d0039',
            '790000', '7b3000', '7c4900', '827a00', '3e6617', '045f20', '005824', '005951', '005b7e', '003562', '002056', '0c004b', '30004a', '4b0048', '7a0045', '7a0026'
        ];
         
        var row, $iColorPicker = $('<div id="iColorPicker'+elemIndex+'"><table class="pickerTable"><thead></thead><tbody><tr><td style="border:1px solid #000;background:#fff;cursor:pointer;height:60px;-moz-background-clip:-moz-initial;-moz-background-origin:-moz-initial;-moz-background-inline-policy:-moz-initial;" colspan="16" id="colorPreview'+elemIndex+'"></td></tr></tbody></table></div>').css('display','none').appendTo('body');
         
        $.each(hx, function(num, color)
        {
            row += '<td style="background:#' + color + '" hx="' + color + '"></td>';
            if (num % 16 == 15)
            {
                $('<tr>' + row + '</tr>').appendTo($iColorPicker.find('thead'));
                row = '';
            }
        });
         
        return $iColorPicker;
    }
     
    $.iColor = iColor;
})();