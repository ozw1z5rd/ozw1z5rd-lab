// ----------------------------------------------------------------------------
// Include the main OGRE header files
// Ogre.h just expands to including lots of individual OGRE header files
// ----------------------------------------------------------------------------
#include <Ogre.h>
// ----------------------------------------------------------------------------
// Include the OGRE example framework
// This includes the classes defined to make getting an OGRE application running
// a lot easier. It automatically sets up all the main objects and allows you to
// just override the bits you want to instead of writing it all from scratch.
// ----------------------------------------------------------------------------
#include <ExampleApplication.h>
#include "MyExampleFrameListener.h"
#define USE_RTSHADER_SYSTEM\

Ogre::SceneNode* rotating_head;
Ogre::SceneNode* rotating_head2;
Ogre::SceneNode* house_node;
Ogre::Entity*    mOceanSurfaceEnt;


    Ogre::GpuProgramParametersSharedPtr mActiveVertexParameters;


    Ogre::TextureFilterOptions mFiltering;
    int mAniso;

    Ogre::MaterialPtr     mActiveMaterial;
    Ogre::Pass*           mActivePass;

    Ogre::GpuProgramPtr                 mActiveFragmentProgram;
    Ogre::GpuProgramPtr                 mActiveVertexProgram;
    Ogre::GpuProgramParametersSharedPtr mActiveFragmentParameters;






// ----------------------------------------------------------------------------
// Define the application object
// This is derived from ExampleApplication which is the class OGRE provides to
// make it easier to set up OGRE without rewriting the same code all the time.
// You can override extra methods of ExampleApplication if you want to further
// specialise the setup routine, otherwise the only mandatory override is the
// 'createScene' method which is where you set up your own personal scene.
// ----------------------------------------------------------------------------
class SampleApp : public ExampleApplication
{
public:
    // Basic constructorĽ
    SampleApp()
    {}

    bool __frameRenderingQueued(const FrameEvent& evt)
    {
        std::cout << -evt.timeSinceLastFrame * 1.5;
        // spin the head around and make it float up and down
        return 0;
        //mPivot->setPosition(0, Math::Sin(mRoot->getTimer()->getMilliseconds() / 150.0) * 10, 0);
        //mPivot->yaw(Radian(-evt.timeSinceLastFrame * 1.5));
        //return SdkSample::frameRenderingQueued(evt);
    }


protected:


//
//
//
    void cleanupContent()
    {
        // get rid of the shared pointers before shutting down ogre or exceptions occure
        std::cout << "Imposto i servizi per gli shader di texture\n";
        mActiveFragmentProgram.setNull();
        mActiveFragmentParameters.setNull();
        mActiveVertexProgram.setNull();
        mActiveVertexParameters.setNull();
        mActiveMaterial.setNull();
        std::cout << "Impostazione terminata\n";
    }





    // Just override the mandatory create scene method
    void createScene(void)
    {


// questi sono definiti come meteriali ( script che descrivono cosa deve fare il materiale )

        // Create the SkyBox
        //mSceneMgr->setSkyBox(true, "Examples/CloudyNoonSkyBox"); EarlyMorningSkyBox

        Ogre::ColourValue fadeColour(0.9, 0.9, 0.9);
        mSceneMgr->setSkyBox(true, "Examples/SpaceSkyBox");
        //mSceneMgr->setFog( Ogre::FOG_LINEAR, fadeColour, 0.0, 1000, 1500 );



        // put an ogre head in the middle of the field
        Entity* head = mSceneMgr->createEntity("Head",  "ogrehead.mesh");
        Entity* head2 = mSceneMgr->createEntity("Head2", "ogrehead.mesh");
        Entity* house = mSceneMgr->createEntity("house", "tudorhouse.mesh");


        ParticleSystem* smoke = mSceneMgr->createParticleSystem("Smoke2", "Examples/Smoke");
        // ---------------------------------------------------------------------------------
        rotating_head = mSceneMgr->getRootSceneNode()->createChildSceneNode(Vector3(0, 0, 0)); // xyz
        rotating_head->attachObject(head);

        rotating_head2 = mSceneMgr->getRootSceneNode()->createChildSceneNode(Vector3(100, 0, 0));
        rotating_head2->attachObject(head2);

        house_node = mSceneMgr->getRootSceneNode()->createChildSceneNode(Vector3(500, 500, 700));
        house_node->attachObject(house);


        mSceneMgr->getRootSceneNode()->createChildSceneNode(Vector3(100, 100, 0))->attachObject(smoke);
        mSceneMgr->getRootSceneNode()->createChildSceneNode(Vector3(0,100,0))->attachObject(mSceneMgr->createParticleSystem("Smoke", "Examples/Smoke"));

        // turn off ambient light
        mSceneMgr->setAmbientLight(ColourValue::Black);

        ColourValue lightColour(1, 1, 0.3);

        // create a light
        Light* light = mSceneMgr->createLight();
        light->setDiffuseColour(lightColour);
        light->setSpecularColour(1, 1, 0.3);
        light->setAttenuation(1500, 1, 0.0005, 0);
        light->setPosition(20, 80, 50);

//
// questo dovrebbe impostare l'oceano
//                                     ------------------------------------------------------------------------------------------

// ???
        this->cleanupContent();

        Ogre::Plane oceanSurface;

        oceanSurface.normal = Ogre::Vector3::UNIT_Y;

        oceanSurface.d = 20;

        Ogre::MeshManager::getSingleton().createPlane("OceanSurface",
                Ogre::ResourceGroupManager::DEFAULT_RESOURCE_GROUP_NAME,
                oceanSurface,
                1000, 1000, 1, 1, true, 1, 1, 1, Ogre::Vector3::UNIT_Z
        );

        mOceanSurfaceEnt = mSceneMgr->createEntity( "OceanSurface", "OceanSurface" );
        mSceneMgr->getRootSceneNode()->createChildSceneNode()->attachObject(mOceanSurfaceEnt);


//
// -------------------------------------------------------------------------------------------------------------------------------
//


    }


    virtual void createFrameListener(void)
    {

        std::cout  <<  "------------------------------------------------------\n";
        std::cout  << "create frame listener\n";
        std::cout  <<  "------------------------------------------------------\n";
        MyExampleFrameListener* mFrameListener = new MyExampleFrameListener(mWindow, mCamera);
        // ------------------=======================================--------------
        mFrameListener->showDebugOverlay(true);
        mRoot->addFrameListener(mFrameListener);
    }

};


// ----------------------------------------------------------------------------
// Main function, just boots the application object
// ----------------------------------------------------------------------------
#if OGRE_PLATFORM == OGRE_PLATFORM_WIN32
#define WIN32_LEAN_AND_MEAN
#include "windows.h"
INT WINAPI WinMain( HINSTANCE hInst, HINSTANCE, LPSTR strCmdLine, INT )
#else
int main(int argc, char **argv)
#endif
{
    // Create application object
    SampleApp app;

    try
    {
        app.go();
    }
    catch( Exception& e )
    {
#if OGRE_PLATFORM == OGRE_PLATFORM_WIN32
        MessageBox( NULL, e.getFullDescription().c_str(), "An exception has occured!", MB_OK | MB_ICONERROR | MB_TASKMODAL);
#else

        std::cerr << "An exception has occured: " << e.getFullDescription();
#endif
    }

    return 0;
}



/*

                      shaderControlSlider->show();
                        size_t controlIndex = startControlIndex + i;
                        const ShaderControl& ActiveShaderDef = mMaterialControlsContainer[mCurrentMaterial].getShaderControl(controlIndex);
                        shaderControlSlider->setRange(ActiveShaderDef.MinVal, ActiveShaderDef.MaxVal, 50, false);
                        shaderControlSlider->setCaption(ActiveShaderDef.Name);


*/

