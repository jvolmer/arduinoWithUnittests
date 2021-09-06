#include "controller/spaceship.hpp"
#include "model/button.hpp"
#include "model/hyperdrive.hpp"
#include "model/laser.hpp"
#include <boost/test/unit_test.hpp>
#include <turtle/mock.hpp>

MOCK_BASE_CLASS( MockButton, Button )
{
    MOCK_METHOD( setup, 0);
    MOCK_METHOD( read, 0 );
    MOCK_METHOD( isPressed, 0, bool());
};

MOCK_BASE_CLASS( MockHyperdrive, Hyperdrive )
{
    MOCK_METHOD( setup, 0 );
    MOCK_METHOD( activate, 0);
    MOCK_METHOD( deactivate, 0);
};

MOCK_BASE_CLASS( MockLaser, Laser )
{
    MOCK_METHOD( setup, 0 );
    MOCK_METHOD( fire, 0);
    MOCK_METHOD( stop, 0);
};

BOOST_AUTO_TEST_SUITE (spaceshipActions)

BOOST_AUTO_TEST_CASE( deactivatesHyperdriveAndFiresLaserWhenButtonIsPressed )
{
    MockButton button;
    MockHyperdrive hyperdrive;
    MockLaser laser;
    Spaceship spaceship(&button, &hyperdrive, &laser);

    MOCK_EXPECT( button.read ).at_least(1);
    MOCK_EXPECT( button.isPressed ).returns(true);

    MOCK_EXPECT( hyperdrive.deactivate ).once();
    MOCK_EXPECT( laser.fire ).once();

    spaceship.loop();
}

BOOST_AUTO_TEST_CASE( activatesHyperdriveAndStopsLaserWhenButtonIsNotPressed )
{
    MockButton button;
    MockHyperdrive hyperdrive;
    MockLaser laser;
    Spaceship spaceship(&button, &hyperdrive, &laser);

    MOCK_EXPECT( button.read ).at_least(1);
    MOCK_EXPECT( button.isPressed ).returns(false);

    MOCK_EXPECT( hyperdrive.activate ).once();
    MOCK_EXPECT( laser.stop ).once();

    spaceship.loop();
}

BOOST_AUTO_TEST_SUITE_END()
