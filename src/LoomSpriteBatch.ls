package
{
    import cocos2d.*;

    import UI.Label;

    public class LoomSpriteBatch extends Cocos2DGame
    {
        private var spriteBatch:CCSpriteBatchNode;
        private var NUM_SPRITES:int = 5000;

        override public function run():void
        {
            // Comment out this line to turn off automatic scaling.
            layer.scaleMode = ScaleMode.LETTERBOX;

            super.run();

            var pic =  "assets/blowfish.png"; 
            spriteBatch = CCSpriteBatchNode.create(pic);
            layer.addChild(spriteBatch);
            var s = CCDirector.sharedDirector().getWinSize();

            for (var i=0; i<NUM_SPRITES; i++) {
                var rect = new CCRect();
                rect.setRect(0,0,64,64);
                var sprite = CCSprite.spriteWithFile(pic, rect);
                // var sprite = CCSprite.create(spriteBatch.getTexture(), CCRectMake(0, 0, 64, 64));
                sprite.setPosition(Math.random()*s.width, Math.random()*s.height);

                var scale_big = CCScaleBy.create(Math.random()*2 + 1, 2, 2);
                var scale_big_back = scale_big.reverse();

                var scale_small = CCScaleBy.create(Math.random()*2+1, -2, -2);
                var scale_small_back = scale_small.reverse();
                
                var array = CCArray.array();
                array.addObject(scale_big);
                array.addObject(scale_big_back);
                array.addObject(scale_small);
                array.addObject(scale_small_back);
                var seq_scale = CCSequence.create( array ) as CCActionInterval;

                sprite.runAction(CCRepeatForever.create(seq_scale));

                var rotate = CCRotateBy.create(Math.random() % 2 + 1, (Math.random() % 720) - 360);
                sprite.runAction(CCRepeatForever.create(rotate) );
                setupMovement(sprite, s); 

                spriteBatch.addChild(sprite);  
            }
        }

        function setupMovement(sprite:CCSprite, s:CCSize):void
        {
            // pick a random point and move to it
            var move = CCMoveTo.create(Math.random() * 4  + 0.5,                 
                new CCPoint( Math.random() * s.width, 
                    Math.random() * s.height ) );
            var move2 = CCMoveTo.create(Math.random() * 4  + 0.5,                 
                new CCPoint( Math.random() * s.width, 
                    Math.random() * s.height ) );
            var array = CCArray.array();
            array.addObject(move);
            array.addObject(move2);
            var seq_move = CCSequence.create( array ) as CCActionInterval;

            // LoomScript not support CCCallFuncN, might consider using Tween instead?
            // var moveDone = CCTargetedAction.actionWithTarget( this, callfuncN_selector(spriteMoveFinished));
            // sprite.runAction( CCSequence.actions(move, moveDone, NULL));
            sprite.runAction( CCRepeatForever.create(seq_move));

        }
        /*
        function spriteMoveFinished(sender:CCNode):void
        {
            // finished moving, so pick a new random point
            var sprite = sender as CCSprite;
            var s = CCDirector.sharedDirector().getWinSize();
            setupMovement(sprite, s);
        }
        */
    }
}